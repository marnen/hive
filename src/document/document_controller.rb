class DocumentController < ApplicationController
  set_model 'DocumentModel'
  set_view 'DocumentView'
  set_close_action :exit
end
