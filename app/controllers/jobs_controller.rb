class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :update, :start, :stop, :complete]

  def index
    @jobs = current_user.jobs.order(created_at: :desc)
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = current_user.buyer_jobs.build(job_params)
    @job.status = Job::PENDING

    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def start
    if @job.pending?
      @job.in_progress!
      redirect_to @job, notice: 'Job has been started.'
    else
      redirect_to @job, alert: 'Job cannot be started.'
    end
  end

  def stop
    if @job.in_progress?
      @job.cancelled!
      redirect_to @job, notice: 'Job has been stopped.'
    else
      redirect_to @job, alert: 'Job cannot be stopped.'
    end
  end

  def complete
    if @job.in_progress?
      @job.completed!
      redirect_to @job, notice: 'Job has been completed.'
    else
      redirect_to @job, alert: 'Job cannot be completed.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :budget, :deadline)
  end
end 