ActiveAdmin.register Tournament do
permit_params :title, :date, :fishing_ground, :fish_name, :fish_size, :fish_image, :comment
end
