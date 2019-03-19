gulp       = require('gulp')
sequence   = require('run-sequence')
clean      = require('gulp-clean')
coffee     = require('gulp-coffee')
uglify     = require('gulp-uglify')
less       = require('gulp-less')
minify_css = require('gulp-minify-css')
jade       = require('gulp-jade')

# top level assets folder
assets_src = './assets'

# html files in root directory
html_src = './*.html'

# coffeescript code files
code_src  = './src/code/*.coffee'

# library files
code_libraries_js     = './src/code/libraries/*.js'
code_libraries_coffee = './src/code/libraries/*.coffee'

# code destination
code_dest = './assets/code/'

# less style files
style_src = './src/style/*.less'

# css libraries
style_libraries_css = './src/style/libraries/*.css'

# style destination
style_dest = './assets/style/'

# jade template pages
template_src = './src/templates/*.jade'

# jade template subdirectories
template_subdirectory_src = './src/templates/**/*.jade'

# root project directory
root_dest = './'

# image files
image_src = './assets/images/*.png'

# image destination
image_dest = './assets/images/'

# download files
download_src = './src/downloads/*'

# download destination
download_dest = './assets/downloads/'

# bower libraries
jquery_js     = './bower_components/jquery/dist/jquery.min.js'
bootstrap_js  = './bower_components/bootstrap/dist/js/bootstrap.min.js'
bootstrap_css = './bower_components/bootstrap/dist/css/bootstrap.min.css'
timeago_js    = './bower_components/jquery-timeago/jquery.timeago.js'

# delete the assets folder and all site contents
gulp.task 'clean-assets', ->
  gulp.src(assets_src, read: false)
    .pipe(clean())

# remove the html files from the root directory
gulp.task 'clean-html', ->
  gulp.src(html_src, read: false)
    .pipe(clean())

# compile the coffeescript code into the assets folder
gulp.task 'compile-code', ->
  gulp.src(code_src)
    .pipe(coffee(bare: true))
    .pipe(uglify())
    .pipe(gulp.dest(code_dest))

# copy the js libraries into the assets folder
gulp.task 'copy-libraries-js', ->
  gulp.src(code_libraries_js)
    .pipe(uglify())
    .pipe(gulp.dest(code_dest))

# compile the coffeescript libraries into the assets folder
gulp.task 'compile-libraries-coffee', ->
  gulp.src(code_libraries_coffee)
    .pipe(coffee(bare: true))
    .pipe(uglify())
    .pipe(gulp.dest(code_dest))

# compile the less style sheets into the assets folder
gulp.task 'compile-style', ->
  gulp.src(style_src)
    .pipe(less())
    .pipe(minify_css(keepSpecialComments: 0))
    .pipe(gulp.dest(style_dest))

# copy the css libraries into the assets folder
gulp.task 'copy-libraries-css', ->
  gulp.src(style_libraries_css)
    .pipe(minify_css(keepSpecialComments: 0))
    .pipe(gulp.dest(style_dest))

# compile the jade pages to the root directory
gulp.task 'compile-templates', ->
  gulp.src(template_src)
    .pipe(jade())
    .pipe(gulp.dest(root_dest))

# copy images to the assets folder
gulp.task 'copy-images', ->
  gulp.src(image_src)
    .pipe(gulp.dest(image_dest))

# copy downloads to the assets folder
gulp.task 'copy-downloads', ->
  gulp.src(download_src)
    .pipe(gulp.dest(download_dest))

# copy bower js libraries to the assets folder
gulp.task 'copy-bower-js', ->
  gulp.src([jquery_js, bootstrap_js, timeago_js])
    .pipe(gulp.dest(code_dest))

# copy bower css libraries to the assets folder
gulp.task 'copy-bower-css', ->
  gulp.src(bootstrap_css)
    .pipe(gulp.dest(style_dest))

# clean everything
gulp.task 'clean-up', ->
  sequence(
    'clean-assets'
    'clean-html'
  )

# run everything
gulp.task 'compile', ->
  sequence(
    'clean-assets'
    'clean-html'
    'compile-code'
    'copy-libraries-js'
    'compile-libraries-coffee'
    'compile-style'
    'copy-libraries-css'
    'compile-templates'
    'copy-images'
    'copy-bower-js'
    'copy-bower-css'
    'downloads'
  )

# only compile when source files change
gulp.task 'watch-files', ->
  gulp.watch(code_src, ['compile-code'])
  gulp.watch(code_libraries_js, ['copy-libraries-js'])
  gulp.watch(code_libraries_coffee, ['compile-libraries-coffee'])
  gulp.watch(style_src, ['compile-style'])
  gulp.watch(style_libraries_css, ['copy-libraries-css'])
  gulp.watch(template_subdirectory_src, ['compile-templates'])
  gulp.watch(image_src, ['copy-images'])

# run this command to start developing
gulp.task 'develop', ['compile', 'watch-files']


# REBUILD ALL ZIP DOWNLOADS
zip        = require('gulp-zip')
dest       = './src/downloads/'
final_dest = './assets/downloads/'

source = (src)->
  return [
    "!/libraries/#{src}/extras/**/*",
    "!/libraries/#{src}/extras",
    "/libraries/#{src}/**/*"
  ]

gulp.task 'downloads', ->
  sequence('clean-downloads', "build-downloads", "copy-downloads")

# delete all zip files in the downloads folder
gulp.task 'clean-downloads', ->
  gulp.src(dest, read: false)
    .pipe(clean())
  gulp.src(final_dest, read: false)
    .pipe(clean())

# run this task to rebuild the download zip files
gulp.task 'build-downloads', ->
  gulp.src(source("RBD_Capacitance"))
    .pipe(zip("RBD_Capacitance.zip"))
    .pipe(gulp.dest(dest))

  gulp.src(source("RBD_LightSensor"))
    .pipe(zip("RBD_LightSensor.zip"))
    .pipe(gulp.dest(dest))

  gulp.src(source("RBD_SerialManager"))
    .pipe(zip("RBD_SerialManager.zip"))
    .pipe(gulp.dest(dest))

  gulp.src(source("RBD_Servo"))
    .pipe(zip("RBD_Servo.zip"))
    .pipe(gulp.dest(dest))

  gulp.src(source("RBD_Threshold"))
    .pipe(zip("RBD_Threshold.zip"))
    .pipe(gulp.dest(dest))

  gulp.src(source("RBD_Timer"))
    .pipe(zip("RBD_Timer.zip"))
    .pipe(gulp.dest(dest))

  # Button.zip: RBD_Button, RBD_Timer
  button_src = source("RBD_Button")
    .concat(source("RBD_Timer"))

  gulp.src(button_src, {base: "/libraries"})
    .pipe(zip("Button.zip"))
    .pipe(gulp.dest(dest))

  # HumanSensor.zip: RBD_HumanSensor, RBD_Capacitance, RBD_Threshold
  human_sensor_src = source("RBD_HumanSensor")
    .concat(source("RBD_Capacitance"))
    .concat(source("RBD_Threshold"))

  gulp.src(human_sensor_src, {base: "/libraries"})
    .pipe(zip("HumanSensor.zip"))
    .pipe(gulp.dest(dest))

  # Light.zip: RBD_Light, RBD_Timer
  light_src = source("RBD_Light")
    .concat(source("RBD_Timer"))

  gulp.src(light_src, {base: "/libraries"})
    .pipe(zip("Light.zip"))
    .pipe(gulp.dest(dest))

  # Motor.zip: RBD_Motor, RBD_Timer
  motor_src = source("RBD_Motor")
    .concat(source("RBD_Timer"))

  gulp.src(motor_src, {base: "/libraries"})
    .pipe(zip("Motor.zip"))
    .pipe(gulp.dest(dest))

  # WaterSensor.zip: RBD_WaterSensor, RBD_Capacitance, RBD_Threshold
  water_sensor_src = source("RBD_WaterSensor")
    .concat(source("RBD_Capacitance"))
    .concat(source("RBD_Threshold"))

  gulp.src(water_sensor_src, {base: "/libraries"})
    .pipe(zip("WaterSensor.zip"))
    .pipe(gulp.dest(dest))

  # RBD_Libraries.zip: All Libraries
  libraries_src = source("RBD_Button")
    .concat(source("RBD_Capacitance"))
    .concat(source("RBD_HumanSensor"))
    .concat(source("RBD_Light"))
    .concat(source("RBD_LightSensor"))
    .concat(source("RBD_Motor"))
    .concat(source("RBD_SerialManager"))
    .concat(source("RBD_Servo"))
    .concat(source("RBD_Threshold"))
    .concat(source("RBD_Timer"))
    .concat(source("RBD_WaterSensor"))

  gulp.src(libraries_src, {base: "/libraries"})
    .pipe(zip("RBD_Libraries.zip"))
    .pipe(gulp.dest(dest))
