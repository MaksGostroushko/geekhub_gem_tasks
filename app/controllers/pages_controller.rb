class PagesController < ApplicationController
  require 'will_paginate/array'
  # require 'math'

  def index
    @tasks = GeekHubTasks.singleton_methods - [:yaml_tag] #Singleton methods are defined directly for an object, and not inside the class of this object.Can use it outside the class.
    @tasks = @tasks.paginate(page: params[:page], per_page: params[:per_page] || 8)
  end

  def show
    @task = params[:task]
    @arguments = GeekHubTasks.method(@task).parameters.map { |p| p.last } if @task.present?

    return if params[:args].blank? || params[:args].values.delete_if { |x| x.blank? }.blank?

    values = params[:args].to_unsafe_h.values
    proc = GeekHubTasks.method(@task).curry #curry = If the optional arity argument is given, it determines the number of arguments
    values.map { |e| proc = proc.call(is_numberic?(e) ? e.to_i : e.to_s) }
    @result = proc
  end

  def is_numberic?(str)
      str == "#{str.to_f}" || str == "#{str.to_i}"
  end
end
