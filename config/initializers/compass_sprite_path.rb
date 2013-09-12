Compass.add_configuration(
    {
        :sprite_load_path => Compass.configuration.sprite_load_path + [Rails.root.join('app', 'assets', 'images', 'sprites')]
    }, 'sprites'
)
