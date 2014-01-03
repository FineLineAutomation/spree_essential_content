class Spree::BlogConfiguration < Spree::Preferences::Configuration

  preference :disqus_shortname,  :string, :default => ''
  preference :sharethis_publisher_id, :string, :default => ''

end
