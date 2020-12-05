ActiveAdmin.register Tournament do
permit_params :start_time, :end_time, :fishing_ground, :fishing_style, :main_rule, :measure_rule, :fish_name, :keeper_size, :swap_limit, :judging_limit, :comment
end
