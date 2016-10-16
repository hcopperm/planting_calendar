require 'spec_helper'

describe PlantingTask do
  describe "scopes" do
    let(:time_now)  { DateTime.parse("3 January 2012 2:00 pm pacific") }
    before do
      Timecop.freeze(time_now)
    end

    after do
      Timecop.return
    end

    context "planted_on" do
      let(:corn) { FactoryGirl.create(:planting_task,
                          name: "Corn",
                          ideal_planting_date: Date.today,
                          planted_at: Date.today
                         )
      }

      let(:tomatoes) { FactoryGirl.create(:planting_task,
                              name: "Tomatoes",
                              ideal_planting_date: Date.today,
                              planted_at: Date.today + 1.week
                             )
      }



      it "returns the expected planting tasks" do
        tasks = PlantingTask.planted_on(Date.today)
        expect(tasks).to include(corn)
        expect(tasks).to_not include(tomatoes)
      end
    end

    context "this_week" do
    end


    context "planting_overdue" do
    end

    context "planting_soon" do

    end
  end
end
