module ActsAsStarrable

  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def acts_as_starrable(options={})
      has_many :stars, :as => :starrable, :dependent => :destroy,
                       :counter_cache => true
      extend ActsAsStarrable::SingletonMethods
      include ActsAsStarrable::InstanceMethods
    end
  end

  module SingletonMethods
    def starred_for(starrable)
      Star.find(:all, :conditions => { :starrable_id => starrable.id, :starrable_type => starrable.class.name })
    end
  end

  module InstanceMethods
    def starred_by
      Star.find(:all, :conditions => { :starrable_id => self.id, :starrable_type => self.class.name }).collect(&:user)
    end

    def starred_by?(user)
      Star.exists?({ :starrable_id => self.id, :starrable_type => self.class.name, :user_id => user.id })
    end

    def starred_by!(user)
      unless self.starred_by?(user)
        Star.create!( :user => user, :starrable => self )
      end
    end

    def unstarred_by!(user)
      if self.starred_by?(user)
        self.stars.find_by_user_id(user.id).delete
      end
    end
  end
end
