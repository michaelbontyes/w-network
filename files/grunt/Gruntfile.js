/*global module:false*/
module.exports = function(grunt) {
	require('load-grunt-tasks')(grunt); 
	require('logfile-grunt')(grunt, { filePath: 'grunt-log.txt' });
	var timestamp = new Date();
	var timer = require("grunt-timer");
	timer.init(grunt, { deferLogs: true, friendlyTime: true, color: "blue" });

    // Project configuration.
    grunt.initConfig({
	    // Metadata.
	    pkg: grunt.file.readJSON('package.json'),
	    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
	      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
	      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
	      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
	      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n',
	    // Task configuration.
	    sass: {
	      	dist: {
		        options: {
		        	banner: grunt.banner,
			        style: 'expanded',
			        compass: true,
			        check: true
		        },
		        files: {
			        'style.css': 'sass/style.scss'
			    
		      	}
		    }
	    },
	    watch: {
	    	options: {
			    dateFormat: function(time) {
			      grunt.log.writeln('The watch finished in ' + time + 'ms at' + (new Date()).toString());
			      grunt.log.writeln('Waiting for more changes...');
			    },
			  },
	    	sass: {
		        files: [
		          'sass/*/*.scss',
		          'sass/*.scss'
		        ],
		        tasks: ['sass'],
		        options: {
			      	livereload: false,
			    }
	      	}
	    }
    });

    // These plugins provide necessary tasks.
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-qunit');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-watch');


    // Default task.
    grunt.registerTask('test', 'Testing tasks', function() {
    	grunt.log.write('Grunt is ready to be used at '+ timestamp + ' ').ok();
    });
    grunt.registerTask('default', ['sass:dist', 'watch']);

};
