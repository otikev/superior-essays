// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require('datatables.net-bs4')
require("local-time")

import $ from 'jquery';
global.$ = jQuery;
window.Rails = Rails

import 'bootstrap';
import 'popper.js/dist/popper.js';

require("custom/app")
require("custom/custom")

import LocalTime from 'local-time';
LocalTime.start();

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
