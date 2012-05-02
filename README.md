# ObjectivePosterous

Posterous API Client for Objective-C with minimal features, based on Posterous API v2.

We use this library for our software. If you need a specific feature, you probably want to add it yourself and send me a pull request.

## Usage

1. Initialize Posterous API

````
posterous = [[IGObjectivePosterous alloc] initWithApiToken:kPosterousApiToken
                                                  username:kPosterousUsername 
                                                  password:kPosterousPassword];
tumblr.delegate = self;
````

2. Request user sites

````    
[posterous loadSite];
````

3. Create a post:

````  
IGPPost* post = [[IGPPost alloc] init];
post.title = @"Test Post";
post.body = @"<b>Hello</b>";
[posterous createPost:post withSiteId:kPosterousSiteId];
````

## License

ObjectivePosterous are available under the [MIT license](http://www.opensource.org/licenses/mit-license.php).

## Contact

Francis Chong ([@siuying](http://twitter.com/siuying))
