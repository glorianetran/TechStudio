# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tech_studio = Project.create!(:title => 'Tech Studio', :creator => 'Team Make It Work',
    :description => 'Platform for collaboration on interdisciplinary tech projects.')
arduino = Project.create!(:title => 'Arduino Knitwear Project', :creator => 'Suzie McStrugglebus',
    :description => 'I want to create fun knitted hats with lights and music.')
music = Project.create!(:title => 'Computer Music Band', :creator => 'Logarhythms',
    :description => "Let's make nerdy computer music together!")

tech_studio.tag_list=("Rails, web")
arduino.tag_list=("C, Arduino, knitting, wearables")
music.tag_list=("music, Ableton, web")

