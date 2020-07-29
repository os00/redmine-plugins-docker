#    This file is part of Gemavatar.
#
#    Gemavatar is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Gemavatar is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Gemavatar.  If not, see <http://www.gnu.org/licenses/>.

# CHANGE - this code was originaly in application_helper_gemavatr_patch.rb,
# code was moved because avatars are now in avatars helper and the name of file
# wouldn't correspond to the functionality

# CHANGE
# require 'application_helper'
require 'avatars_helper'

module GemAvatarPlugin
    module ApplicationAvatarPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do
                # ERROR, alias_method_chain was removed from rails
                # alias_method_chain :avatar, :gemavatar
                alias_method :avatar_without_gemavatar, :avatar
                alias_method :avatar, :avatar_with_gemavatar
            end
        end
        module InstanceMethods
            def avatar_with_gemavatar(user, options = { })
                if Setting.gravatar_enabled? && user.is_a?(User)
                    options.merge!({:ssl => (defined?(request) && request.ssl?), :default => Setting.gravatar_default})
                    options[:size] = "64" unless options[:size]
                    avatar_url = url_for :controller => :pictures, :action => :delete, :user_id => user
                    return "<img class=\"gravatar\" width=\"#{options[:size]}\" height=\"#{options[:size]}\" src=\"#{avatar_url}\" />".html_safe
                else
                    ''
                end
            end
        end
    end
end
