// Include gulp
var gulp = require('gulp');

// Include Our Plugins
var sass = require('gulp-sass');

// Compile Our Sass
gulp.task('styles', function() {
    return gulp.src('scss/*.scss')
        .pipe(sass())
        .pipe(gulp.dest('css'));
});


// Watch Files For Changes
gulp.task('watch', function() {
    gulp.watch('scss/*.scss', ['styles']);
});

// Default Task
gulp.task('default', ['styles', 'watch']);