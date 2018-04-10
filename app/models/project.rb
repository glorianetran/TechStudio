class Project < ApplicationRecord
    has_many :taggings
    has_many :tags, through: :taggings
    has_many :projectusers
    has_many :users, through: :projectusers
    has_many :collaborators, -> {where(projectusers: {collaborator: true})}, :through => :projectusers, :class_name=> 'User', :source => :user
    has_many :potentials, -> {where(projectusers: {collaborator: false})}, :through => :projectusers, :class_name=> 'User', :source => :user
    
    def self.tagged_with(name)
        Tag.find_by!(name: name).projects
    end

    def self.tag_counts
        Tag.select('tags.id, tags.name, count(taggings.tag_id) as count').joins(:taggings).group("taggings.tag_id, tags.id, tags.name")
    end

    def tag_list
        tags.map(&:name).join(', ')
    end
    
    def tag_list=(names)
        self.tags = names.downcase.split(',').map do |n|
            Tag.where(name: n.strip).first_or_create!
        end
    end
    
    # creator methods
    def add_creator=(user)
        Projectuser.where(user_id: user).where(project_id: self.id).first_or_create!(:project_id => self.id, :user_id => user, :collaborator => true, :creator => true)
    end
    
    def creator
       User.find_by(id: Projectuser.select('user_id').where(project_id: self.id).where(creator: true));
    end
    
    # collaborator methods
    def collaborator_list
        collaborators.map(&:name).join(', ')
    end
    
    def add_collaborator=(user)
        Projectuser.where(user_id: user).where(project_id: self.id).first_or_create!(:project_id => self.id, :user_id => user, :collaborator => true, :creator => false)
    end
    
    
    # potential methods
    def add_potential=(user)
        Projectuser.where(user_id: user).create!(:project_id => self.id, :user_id => user, :collaborator => false, :creator => false)
    end
    
    def potential_list
       potentials.map(&:name).join(', ') 
    end
    
    def approve(user)
        Projectuser.where(user_id: user).update(collaborator: true)
    end
    
    def reject(user_id)
        Projectuser.destroy(user_id);
    end
    
    
end
