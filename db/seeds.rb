# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tech_studio = Project.create!(:title => 'Tech Studio', :summary => 'Platform for collaboration on interdisciplinary tech projects.',:description => 'This is the description', :project_type => 'Hobby', :skills_desired => 'ruby');
arduino = Project.create!(:title => 'Arduino Knitwear Project', :summary => 'Suzie McStrugglebus', :description => 'This is arduino', :project_type => 'Hobby', :skills_desired => 'C++')
music = Project.create!(:title => 'Computer Music Band', :summary => "Let's make nerdy computer music together!", :project_type => "Hobby")

tech_studio.tag_list=("Rails, web, Bootstrap, front end, databases")
arduino.tag_list=("C, Arduino, knitting, wearables")
music.tag_list=("music, Ableton, web")

# add collaborators
user1 = User.create!(:name => 'Regina')
user2 = User.create!(:name => 'Glo')
user3 = User.create!(:name => 'Deana')
user4 = User.create!(:name => 'Natasha')

tech_studio.add_collaborator=user1.id
arduino.add_collaborator=user2.id
music.add_collaborator=user3.id
music.add_collaborator=user1.id

# add a creator
tech_studio.add_creator=user2.id
arduino.add_creator=user1.id
music.add_creator=user4.id