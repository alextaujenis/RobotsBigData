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

# this will compile everything
gulp.task 'compile', [
  'compile-templates'
  'compile-style'
  'compile-code'
]

# only compile when source files change
gulp.task 'watch-files', ->
  gulp.watch(template_src, ['compile-templates'])
  gulp.watch(style_src, ['compile-style'])
  gulp.watch(code_src, ['compile-code'])

# run this command to start developing
gulp.task 'develop', ['watch-files', 'compile']