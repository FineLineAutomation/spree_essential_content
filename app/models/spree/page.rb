class Spree::Page < ActiveRecord::Base
  acts_as_list

  RESERVED_PATHS = /(^\/+(admin|account|cart|checkout|content|login|logout|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user|paypal)+)/

  alias_attribute :name, :title

  validates_presence_of :title
  validates :path, presence: true, uniqueness: { case_sensitive: false }

  scope :active, -> { where(accessible: true) }
  scope :visible, -> { active.where(visible: true) }

  has_many :contents, -> { order(:position) }, dependent: :destroy
  has_many :images, -> { order(:position) }, as: :viewable, class_name: "Spree::PageImage", dependent: :destroy
  before_validation :set_defaults
  after_create :create_default_content

  def self.find_by_path(_path)
    return where(path: '__home__').first if (_path == "__home__" or _path == "/") && self.exists?(path: "/")
    where(path: normalize_path(_path)).first
  end

  def to_param
    path
  end

  def meta_title
    val = read_attribute(:meta_title)
    val.blank? ? title : val
  end

  def for_context(context)
    contents.where(context: context)
  end

  def has_context?(context)
    contents.where(context: context).count > 0
  end

  def matches?(_path)
    (root? && _path == "") || (!root? && _path.match(path))
  end

  def root?
    self.path == "__home__"
  end

  def self.normalize_path(original_path)
    if original_path == "/"
      "__home__"
    else
      original_path.downcase.gsub(/(^[\/\-\_]+)|([\/\-\_]+$)/, "")
    end
  end

  private

    def set_defaults
      return if title.blank?
      self.nav_title = title if nav_title.blank?
      self.path = nav_title.parameterize if path.blank?
      self.path = self.class.normalize_path(path)
    end

    def create_default_content
      self.contents.create(title: title)
    end
end
