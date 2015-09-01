gulp       = require('gulp')
jade       = require('gulp-jade')
less       = require('gulp-less')
minify_css = require('gulp-minify-css')

template_src  = './app/templates/**/*.jade'
template_dest = './compiled/'

style_src = './app/style/**/*.less'
style_dest = './compiled/style/'

gulp.task 'compile-templates', ->
  gulp.src(template_src)
    .pipe(jade())
    .pipe(gulp.dest(template_dest))

gulp.task 'compile-style', ->
  gulp.src(style_src)
    .pipe(less())
    .pipe(minify_css(keepSpecialComments: 0))
    .pipe(gulp.dest(style_dest))

# this will compile everything
gulp.task 'compile', [
  'compile-templates',
  'compile-style'
]

# compile on changes
gulp.task 'watch-files', ->
  gulp.watch([template_src, style_src], ['compile'])

# run this to develop
gulp.task 'develop', ['watch-files','compile']