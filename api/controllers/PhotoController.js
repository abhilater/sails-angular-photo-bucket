/**
 * PhotoController
 *
 * @module      :: Controller
 * @description	:: A set of functions called `actions`.
 *
 *                 Actions contain code telling Sails how to respond to a certain type of request.
 *                 (i.e. do stuff, then send some JSON, show an HTML page, or redirect to another URL)
 *
 *                 You can configure the blueprint URLs which trigger these actions (`config/controllers.js`)
 *                 and/or override them with custom routes (`config/routes.js`)
 *
 *                 NOTE: The code you write here supports both HTTP and Socket.io automatically.
 *
 * @docs        :: http://sailsjs.org/#!documentation/controllers
 */
var count = 0;
var handlePhotosResult = function(err, photos, res) {
    if (err) {
        return console.log(err);
        res.json({'error': 'Error occurred: '+err});
        // Found multiple users!
    } else {
        if(photos){
            //console.log("Photos found:", photos);
            if(!Array.isArray(photos)){
                photos = [photos];
            }
            for (index in photos){
                count++;
                putTags(photos,index, res);
            }

        }else{
            console.log('No results');
            res.json('No results');
        }
    }
}

function putTags(photos, index, res){
    var query = 'select t.label from tagphoto tp inner join tag t on tp."tagId" = t.id where tp."photoId" ='+ photos[index].id;
    //console.log('Query: '+query);
    Tagphoto.query(query, function(err, tags) {
        count--;
        if(err){
            res.json({'error': 'Error occurred fetching tags. Error details: '+ JSON.stringify(err)});
        }else{
            photos[index].tags = getTagsArray(tags.rows);
            console.log('Photo '+photos[index].id+', tags: '+JSON.stringify(photos[index].tags));
            if(count == 0 ) res.json(photos);
        }
    });
}

function getTagsArray(map){
    var array = [];
    for(index in map){
        array.push(map[index].label);
    }
    return array;
}

var uuid = require('node-uuid');
var fs = require('fs');
var mkdirp = require('mkdirp');
var im = require('imagemagick');
//var io = require('socket.io');
 
var UPLOAD_PATH = 'public/uploads';

 
function safeFilename(name) {
	name = name.replace(/ /g, '-');
	name = name.replace(/[^A-Za-z0-9-_\.]/g, '');
	name = name.replace(/\.+/g, '.');
	name = name.replace(/-+/g, '-');
	name = name.replace(/_+/g, '_');
	return name;
}
 
function fileMinusExt(fileName) {
	return fileName.split('.').slice(0, -1).join('.');
}
 
function fileExtension(fileName) {
	return fileName.split('.').slice(-1);
}
 


module.exports = {

    create: function(req, res) {

        var files = req.files;
        var fileKeys = Object.keys(files);
        var listingId = req.body.listingId;
        console.log("Uploading images to listing ID: "+listingId);
        var imageDirPath = UPLOAD_PATH+'/fullSize/'+listingId;
        var thumbDirPath = UPLOAD_PATH+'/thumb/'+listingId;
        // create the directories
        try {
			mkdirp.sync(imageDirPath, 0755);
			mkdirp.sync(thumbDirPath, 0755);
		} catch (e) {
			res.json({
				'error' : 'could not create directory. Error detail: '+e
			});
		}
		console.log("Successfully synced folder paths");
		console.log("Going to iterate over image keys: "+fileKeys);
        if(fileKeys){
        	fileKeys.forEach(function(key){
        		var file = files[key];
        		var id = uuid.v1();
        		console.log("Image key: "+key+", Upload Uuid: "+id);
        		var fileName = id+ "." + fileExtension(safeFilename(file.name));
        		var filePath = imageDirPath+'/'+fileName;
        		var thumbPath = thumbDirPath+'/'+'Thumb_'+fileName;
        		console.log("Full size file path: "+file.path);
        		console.log("Thumbnail file path: "+file.path);
        		fs.readFile(file.path, function(err, data) {
        			if (err) {
        				console.log("ERROR: Reading from temp file path "+JSON.stringify(err));
        				res.json({
        					'error' : 'could not read file. Error Detail:'+err
        				});
        			} else {
        				fs.writeFile(filePath, data, function(err) {
        					if (err) {
        						console.log("ERROR: Writing to full file path "+JSON.stringify(err));
        						res.json({
        							'error' : 'could not write file to storage. Error Detail:'+err
        						});
        					} else {
        						console.log("SUCCESS: Written to full file path. Generating thumbnail..");
        						  // write file to uploads fullsize and thumbs folder
        						  im.resize({
        							  srcPath: filePath,
        							  dstPath: thumbPath,
        							  width:   200
        							}, function(err, stdout, stderr){
        							  if (err) {
        								  console.log("ERROR: Generating thumbnail "+JSON.stringify(err));
        								  res.json({
        	        							'error' : 'Could not create thumbnail. Error Detail:'+err
        	        						});
        							  }else{
	        								console.log('SUCCESS: Thumbnailed image to fit within 200x200px...Saving to DB...');
	        								// persist photo meta-data to database
	              				        	Photo.create({
	              				                name: fileName,
	              				                size: file.size,
	              				                listingId: listingId,
	              				                likes: 0,
	              				                isPrivate: req.body.isPrivate,
	              				                filePath: '/rest/api/photo/p/fullSize/'+listingId+'/'+fileName,
	              				                thumbPath: '/rest/api/photo/p/thumb/'+listingId+'/'+'Thumb_'+fileName
	              				            }).done(function(err, photo) {
	              				                    // Error handling
	              				                    if (err) {
	              				                    	console.log("ERROR: Saving to DB "+JSON.stringify(err));
	              				                    	res.json({
	                  	        							'error' : 'Could not persist to database. Error Detail:'+err
	                  	        						});
	              				                        // The User was created successfully!
	              				                    }else {
	              				                        console.log("SUCCESS: Saved to DB with id: "+photo.id);
	              				                        // Publish socket event for the photo creation to the subscribers
	              				                        Photo.publishCreate({
	              				                        	name: photo.name,
	              				                        	size: photo.size,
	              				                        	id: photo.id,
	              				                        	createdAt: photo.createdAt,
	              				                        	updatedAt: photo.updatedAt,
	              				                        	likes: photo.likes,
	              				                        	listingId: photo.listingId,
	              				                        	isPrivate: photo.isPrivate,
	              				                        	filePath: photo.filePath,
	              				                        	thumbPath: photo.thumbPath
	              				                        });
	              				                        res.json("Successfully created the photo with id: "+photo.id);
	              				                    }
	              				             });
        							  }
        						});
        					}
        				});
        			}
        		});
        	});
        }else{
        	res.json({
				'error' : 'File list is empty'
			});
        }
    },

    destroy: function(req, res) {
        Photo.destroy({
            id: req.params.id
        }).done(function(err) {

                if (err) {
                    return console.log(err);

                } else {
                    console.log("Successfully deleted the photo.");
                    res.json("Successfully deleted the photo.")
                }
            });
    },

    getTags: function(req, res){
        console.log('Inside get tags');
        var photoId = req.params.photoId;
        var query = 'select t.label, t.id from tagphoto tp inner join tag t on tp."tagId" = t.id where tp."photoId" ='+ photoId;
        if(photoId){
            console.log('Inside get tags with photoId'+photoId);
            Tagphoto.query(query, function(err, tags) {
                if(err){
                    res.json({'error': 'Error occurred fetching tags. Error details: '+ JSON.stringify(err)});
                }else{
                    console.log('SUCCESS: Fetching the tags for the photo: '+photoId);
                    res.json(tags.rows);
                }
            });
        }
    },

    find: function(req, res) {
        var listingId = req.params.id;
        var photoId = req.query.photoId;
        if(photoId && listingId){
            Photo.findOne({listingId:listingId, id:photoId}).done(function(err, photos) {handlePhotosResult(err, photos, res);});
        }else{
            Photo.find({isPrivate:false, listingId:listingId}).limit(100).sort('updatedAt DESC').done(function(err, photos) {handlePhotosResult(err, photos, res)});
       }
    },
    
    p: function(req, res) {
        var photoId = req.params.id;
        var imageType = req.params.type;
        var listingId = req.params.listingId;
        var fileName = UPLOAD_PATH+'/'+imageType+'/'+listingId+'/'+photoId;
        console.log(fileName);
        if(photoId && listingId && imageType){
        	fs.readFile(fileName, "binary", function(err, file) {
                if(err) {        
                	res.writeHead(500, {"Content-Type": "text/plain"});
                	res.write(err + "\n");
                	res.end();
                    return;
                }
                res.writeHead(200);
                res.write(file, "binary");
                res.end();
            });
        }else{
        	res.json({
				'error' : 'Photo ID/Listing ID must not be empty'
			});
        }
    },

    tag: function(req, res) {
        var resMessage='';
        var tags = req.body.tags;
        console.log('Tags obtained: '+JSON.stringify(tags));
        if(tags){
            tags.forEach(function(tagItem){
                console.log('Tag value: '+tagItem);
                Tag.findOne({label:tagItem}).done(function(err, tag){

                    if(tag){
                        Tagphoto.findOne({tagId: tag.id, photoId: req.params.id}).done(function(err, tagphoto){
                            if(err){
                                resMessage = "Error occurred creating photo tag: "+err;
                            }else if(tagphoto){
                                resMessage = "Error: Tag already exists for photo";
                            }else{
                                Tagphoto.create({tagId:tag.id, photoId:req.params.id}).done(function(err, tagphoto){
                                    if(err){
                                        resMessage = "Error occurred creating photo tag: "+err;
                                    }else{
                                        resMessage = "Successfully created photo tag: "+tagphoto.id;
                                    }
                                    res.json(resMessage);
                                });
                            }
                        });
                    }else{
                        console.log("Inside else creating Tag val: "+tagItem);
                        Tag.create({label:tagItem, description:''}).done(function(err, createdTag){
                            if(err){
                               resMessage = "Error creating tag: "+err;
                            }else{
                                if(createdTag){
                                    Tagphoto.create({tagId:createdTag.id, photoId:req.params.id}).done(function(err, tagphoto){

                                      if(err){
                                        resMessage = "Error occurred creating photo tag: "+err;
                                      }else if(tagphoto){
                                        resMessage = "Successfully created photo tag: "+tagphoto.id;
                                      }
                                        res.json(resMessage);
                                  });
                                }
                            }
                        });
                    }
                });
            });
        }
    },

    like: function(req, res) {
        Photo.findOne(req.params.id).done(function(err, photo) {
            console.log(photo.likes);
            photo.likes = photo.likes+1;

            // save the updated value
            photo.save(function(err) {
                if(err) console.log("Failed updating likes."+err);
            });
            res.json("Successfully update likes for photo: "+photo.id+", current likes count: "+photo.likes);
        });
    },
    
    subscribe: function(req, res){
       console.log('Inside subscribe');
       /*Photo.find({
			isPrivate : false
		}).done(function(err, photos) {
			Photo.subscribe(req.socket);
			Photo.subscribe(req.socket, photos);
		});*/
       Photo.subscribe(req.socket);
       res.send(200);
    },
  /**
   * Overrides for the settings in `config/controllers.js`
   * (specific to PhotoController)
   */
  _config: {}

  
};
