class Recipe < ApplicationRecord
  include(FriendlyId)
  include(Moderated)

  belongs_to :author, :class_name => "Account"
  has_and_belongs_to_many :diets
  has_and_belongs_to_many :allergies

  Gutentag::ActiveRecord.(self)

  friendly_id :name, :use => [:slugged, :history]

  validates_presence_of :author
  validates_presence_of :slug
  validates_presence_of :ingredients
  validates_presence_of :instructions
  validates_length_of :ingredients, :minimum => 1
  validates_length_of :instructions, :minimum => 1

  def description
    Redcarpet::Render::SmartyPants.render(
      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new(
          :no_links => true,
          :no_styles => true,
          :no_images => true,
          :hard_warp => true
        )
      ).render(
        body
      )
    ).html_safe
  end

  def summary
    body.truncate(69)
  end

  private def should_generate_new_friendly_id?
    super || __send__("#{friendly_id_config.base}_changed?")
  end
end
