module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
      
      when /the home page/
        '/'
      when /the homepage/
        '/'
      when /the sign up page/
        '/sign_up'
      when /the sign in page/
        '/sign_in'        
      when /sign_in/
        '/sign_in'
      when /sign_out/
        '/sign_out'
      when /the users index page/
        '/users/'
      when /admin.media/
        '/admin/media'
      when /the artist detail page for artist id (.*)/
        artist_path($1)
      when /the show detail page for performance (.*)/
        performance_path($1)
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
