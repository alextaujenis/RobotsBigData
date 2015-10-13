gulp       = require('gulp')
jade       = require('gulp-jade')
less       = require('gulp-less')
minify_css = require('gulp-minify-css')
coffee     = require('gulp-coffee')
uglify     = require('gulp-uglify')

template_src  = './app/templates/**/*.jade'
template_dest = './compiled/'

style_src  = './app/style/**/*.less'
style_dest = './compiled/style/'

code_src  = './app/code/**/*.coffee'
code_dest = './compiled/code/'

libraries_src  = './app/libraries/**/*.coffee'
libraries_dest = './compiled/libraries/'


# bower libraries
jquery_js     = './bower_components/jquery/dist/jquery.min.js'
bootstrap_js  = './bower_components/bootstrap/dist/js/bootstrap.min.js'
bootstrap_css = './bower_components/bootstrap/dist/css/bootstrap.min.css'

# index file
index_html = './compiled/index.html'

# images
images_src = './app/images/**/*.png'
images_dest = './compiled/images/'

gulp.task 'compile-templates', ->
  gulp.src(template_src)
    .pipe(jade())
    .pipe(gulp.dest(template_dest))

gulp.task 'compile-style', ->
  gulp.src(style_src)
    .pipe(less())
    .pipe(minify_css(keepSpecialComments: 0))
    .pipe(gulp.dest(style_dest))

gulp.task 'compile-code', ->
  gulp.src(code_src)
    .pipe(coffee(bare: true))
    .pipe(uglify())
    .pipe(gulp.dest(code_dest))

gulp.task 'compile-libraries', ->
  gulp.src(libraries_src)
    .pipe(coffee(bare: true))
    .pipe(uglify())
    .pipe(gulp.dest(libraries_dest))

gulp.task 'copy-bower-js-files', ->
  gulp.src([jquery_js, bootstrap_js])
    .pipe(gulp.dest(libraries_dest))

gulp.task 'copy-bower-css-files', ->
  gulp.src(bootstrap_css)
    .pipe(gulp.dest(style_dest))

gulp.task 'copy-index-to-root', ->
  gulp.src(index_html)
    .pipe(gulp.dest('./'))

gulp.task 'copy-images', ->
  gulp.src(images_src)
    .pipe(gulp.dest(images_dest))

# this will compile everything
gulp.task 'compile', [
  'compile-templates'
  'compile-style'
  'compile-code'
  'compile-libraries'
  'copy-bower-js-files'
  'copy-bower-css-files'
  'copy-index-to-root'
  'copy-images'
]

# only compile when source files change
gulp.task 'watch-files', ->
  gulp.watch(template_src, ['compile-templates'])
  gulp.watch(style_src, ['compile-style'])
  gulp.watch(code_src, ['compile-code'])
  gulp.watch(libraries_src, ['compile-libraries'])

# run this command to start developing
gulp.task 'develop', ['watch-files', 'compile']