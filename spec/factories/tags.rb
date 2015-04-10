FactoryGirl.define do
  factory :tag, :class => ActsAsTaggableOn::Tag do
    sequence(:name) {|n| "tag#{n}" }
    taggings_count 1
  end
end