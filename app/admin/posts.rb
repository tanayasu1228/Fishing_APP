ActiveAdmin.register Post do
permit_params :fish_image, :fish_name, :catch_size, :weight, :lure, :rod, :reel, :line, :range, :user_id, :created_at, :updated_at, :tournament_id
end
