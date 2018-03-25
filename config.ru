require_relative './config/environment'



  if ActiveRecord::Migrator.needs_migration?
    raise "Migrations are pending. Run 'rake db:migrate'"
  end

use Rack::MethodOverride
use RoomsController

use UsersController
run ApplicationController
