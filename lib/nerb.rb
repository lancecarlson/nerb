if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles "nerb/merbtasks", "nerb/slicetasks", "nerb/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :nerb
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:nerb][:layout] ||= :nerb
  
  # All Slice code is expected to be namespaced inside a module
  module Nerb
    
    # Slice metadata
    self.description = "Nerb is a Pocket CMS Slice"
    self.version = "0.0.1"
    self.author = "Lance Carlson"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(Nerb)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :nerb_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # example of a named route
      scope.namespace :admin do |admin|
        admin.resources :pages
        admin.resources :links
        admin.resources :users
      end
      
      scope.match('/admin').to(:namespace => "merb_auth", :controller => "sessions", :action => "new")
      
      scope.add_slice(:MerbAuth, :path => "admin", :default_routes => false)
    end
    
  end
  
  # Setup the slice layout for Nerb
  #
  # Use Nerb.push_path and Nerb.push_app_path
  # to set paths to nerb-level and app-level paths. Example:
  #
  # Nerb.push_path(:application, Nerb.root)
  # Nerb.push_app_path(:application, Merb.root / 'slices' / 'nerb')
  # ...
  #
  # Any component path that hasn't been set will default to Nerb.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  Nerb.setup_default_structure!
  
  # Add dependencies for other Nerb classes below. Example:
  #dependency "nerb/other"
  dependencies "dm-types", "dm-validations", "dm-serializer", "dm-aggregates", "dm-is-state_machine"
  
  dependencies "merb-auth"
  
  use_orm :datamapper
end