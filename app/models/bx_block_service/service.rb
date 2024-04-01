module BxBlockService
  class Service < ApplicationRecord
    belongs_to :account, class_name: 'AccountBlock::Account', foreign_key: 'account_id'
    has_many :bookings, class_name: 'BxBlockBooking::Booking', foreign_key: 'service_id'
    # before_save :set_price

    enum service_department: {
      interior_painting: 'Interior Painting',
      exterior_painting: 'Exterior Painting',
      wallpaper_removal: 'Wallpaper Removal',
      sheetrock_repair: 'Sheetrock Repair',
      interior_lighting_installation: 'Interior Lighting Installation',
      exterior_lighting_installation: 'Exterior Lighting Installation',
      electrical_services: 'Electrical Services',
      plumbing_repair: 'Plumbing Repair',
      window_replacement: 'Window Replacement',
      door_replacement: 'Door Replacement',
      cabinet_installation: 'Cabinet Installation',
      appliance_repair_installation: 'Appliance Repair & Installation',
      dryer_duct_cleaning: 'Dryer Duct Cleaning',
      bathroom_renovation: 'Bathroom Renovation',
      kitchen_renovation: 'Kitchen Renovation',
      exterior_wood_replacement: 'Exterior Wood Replacement',
      deck_repair: 'Deck Repair',
      deck_sealing_cleaning: 'Deck Sealing and Cleaning',
      concrete_cleaning_patching: 'Concrete Cleaning and Patching',
      siding_repair_replacement: 'Siding Repair or Replacement',
      fence_repair: 'Fence Repair',
      roof_repair: 'Roof Repair',
      gutter_cleaning: 'Gutter Cleaning',
      pressure_washing: 'Pressure Washing',
      debris_removal: 'Debris Removal',
      graffiti_removal: 'Graffiti Removal',
      locksmith_services: 'Locksmith Services'
    }
  end
end

