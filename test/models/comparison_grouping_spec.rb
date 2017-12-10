require 'rails_helper'

describe ComparisonGrouping do
  let!(:time_frame) { Fabricate(:time_frame) }
  let!(:grouping) do
    Fabricate(:comparison_grouping,
              time_frame: time_frame)
  end

  let!(:property_cashflow_reports_1) do
    Fabricate(:property_cashflow_report,
              comparison_grouping: grouping,
              time_frame: time_frame)
  end

  let!(:property_cashflow_reports_2) do
    Fabricate(:property_cashflow_report,
              comparison_grouping: grouping,
              time_frame: time_frame)
  end

  let!(:property_cashflow_reports_3) do
    Fabricate(:property_cashflow_report,
              comparison_grouping: grouping,
              time_frame: time_frame)
  end

  let!(:property_cashflow_reports_4) do
    Fabricate(:property_cashflow_report)
  end

  context 'grouping associations' do
    it 'returns all associated property cashflow reports' do
      expect(grouping.property_cashflow_reports.count).to eq(3)
    end
  end
end
