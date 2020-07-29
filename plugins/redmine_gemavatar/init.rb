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

require 'redmine'
require 'gravatar'

# CHANGE - code now moved to avatars_helper_... file because avatars are now in
# avatars helper not in application helper
# require 'application_helper_gemavatar_patch'
require 'avatars_helper_gemavatar_patch'
require 'gemavatar_hooks'

Redmine::Plugin.register :redmine_gemavatar do
  name 'Ldap avatar plugin'
  author 'Andrea Guarino + Antoni Segura Puimedon'
  description 'Fetches avatars from LDAP'
  version '1.1'
  url ''
  author_url 'https://gitlab.com/u/aguarino/gemavatar'
  requires_redmine :version_or_higher => '3.2.1'

  settings :default => {'refresh_days' => '7', 'LDAP_photoprop' =>'thumbnailphoto'}, :partial => 'settings/gemavatar'
end

RedmineApp::Application.config.after_initialize do
    # CHANGE - avatars are now in AvatarsHelper
    # ApplicationssHelper.send(:include, GemAvatarPlugin::ApplicationAvatarPatch)
    AvatarsHelper.send(:include, GemAvatarPlugin::ApplicationAvatarPatch)
end
