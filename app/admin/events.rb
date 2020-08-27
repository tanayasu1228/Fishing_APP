ActiveAdmin.register Event do
  permit_params :name, :event_date, :details
end
