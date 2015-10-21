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

# root project directory
root_dest = './'

# image files
image_src = './src/images/*.png'

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
  gulp.src([jquery_js, bootstrap_js])
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
    'copy-downloads'
    'copy-bower-js'
    'copy-bower-css'
  )

# only compile when source files change
gulp.task 'watch-files', ->
  gulp.watch(code_src, ['compile-code'])
  gulp.watch(code_libraries_js, ['copy-libraries-js'])
  gulp.watch(code_libraries_coffee, ['compile-libraries-coffee'])
  gulp.watch(style_src, ['compile-style'])
  gulp.watch(style_libraries_css, ['copy-libraries-css'])
  gulp.watch(template_src, ['compile-templates'])
  gulp.watch(image_src, ['copy-images-'])

# run this command to start developing
gulp.task 'develop', ['compile', 'watch-files']