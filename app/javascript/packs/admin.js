require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "bootstrap";
// import 'cocoon-js'
import './src/admin.scss';


require('jquery')
require('jquery-ui')
// require('jquery-fileupload')
// require ('jquery-fileupload/basic')
// import 'jquery-fileinput'
require("@nathanvda/cocoon")
require('./js/lessons')
require('./js/courses')


// require("trix")
// require("@rails/actiontext")