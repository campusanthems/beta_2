namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    School.create!(:name => "Villanova", :banner_color => "#BA0030", :background_color => "#dceefa");
    School.create!(:name => "University Of New Mexico", :banner_color => "#BA0030", :background_color => "#Bf0f0f");
  end
end