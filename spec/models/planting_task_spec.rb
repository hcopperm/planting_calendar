require 'spec_helper'

describe PlantingTask do
  describe "scopes" do
  # scopes:
    # unplanted
    # unharvested
    # planted
    # harvested
    # planted_on
    # this_week
    # today
    # planting_overdue
    # planting_soon

    let(:time_now)  { DateTime.parse("3 January 2012 2:00 pm pacific") }

    let(:today_corn)  {
      FactoryGirl.create(:planting_task,
                          name: "Corn",
                          ideal_planting_date: Date.today,
                          planted_at: Date.today
      )
    }

    let(:next_week_tomatoes) {
      FactoryGirl.create(:planting_task,
                          name: "Tomatoes",
                          ideal_planting_date: Date.today,
                          planted_at: Date.today + 1.week
      )
    }

    let(:overdue_potatoes) {
      FactoryGirl.create(:planting_task,
                          name: "Potatoes",
                          ideal_planting_date: Date.today - 1.week,
      )
    }

    let(:planting_soon_peas) {
      FactoryGirl.create(:planting_task,
                          name: "Peas",
                          ideal_planting_date: Date.today + 1.day,
      )
    }

    let(:harvested_lettuce) {
      FactoryGirl.create(:planting_task,
                          name: "Lettuce",
                          ideal_planting_date: Date.today - 1.week,
                          planted_at: Date.today - 1.week,
                          completed: Date.today
      )

    }

    before do
      Timecop.freeze(time_now)
    end

    after do
      Timecop.return
    end

    context "planted_on" do
      it "returns the expected planting tasks" do
        tasks = PlantingTask.planted_on(Date.today)
        expect(tasks).to include(today_corn)
        expect(tasks).to_not include(next_week_tomatoes)
      end
    end

    context "this_week" do
      it "returns the expected planting tasks" do
        tasks = PlantingTask.this_week
        expect(tasks).to include(today_corn)
        expect(tasks).to_not include(next_week_tomatoes)
      end
    end


    context "planting_overdue" do
      it "returns the expected planting tasks" do
        tasks = PlantingTask.planting_overdue
        expect(tasks).to include(overdue_potatoes)
        expect(tasks).to_not include(today_corn)
        expect(tasks).to_not include(next_week_tomatoes)
      end
    end

    context "planting_soon" do
      it "returns the expected planting tasks" do
        tasks = PlantingTask.planting_soon
        expect(tasks).to include(planting_soon_peas)
        expect(tasks).to_not include(today_corn)
        expect(tasks).to_not include(next_week_tomatoes)
        expect(tasks).to_not include(overdue_potatoes)
      end
    end

    context "harvested" do
      it "returns the expected planting tasks" do
        tasks = PlantingTask.harvested
        expect(tasks).to include(harvested_lettuce)
        expect(tasks).to_not include(today_corn)
        expect(tasks).to_not include(next_week_tomatoes)
        expect(tasks).to_not include(overdue_potatoes)
      end
    end

  end
end
