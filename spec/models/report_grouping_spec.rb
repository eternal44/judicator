require 'rails_helper'

describe ReportGrouping do
  let!(:time_frame) { Fabricate(:time_frame) }
  let!(:grouping) do
    Fabricate(:report_grouping,
              time_frame: time_frame)
  end

  let!(:report_1) do
    Fabricate(:report,
              report_grouping: grouping,
              time_frame: time_frame)
  end

  let!(:report_2) do
    Fabricate(:report,
              report_grouping: grouping,
              time_frame: time_frame)
  end

  let!(:report_3) do
    Fabricate(:report,
              report_grouping: grouping,
              time_frame: time_frame)
  end

  let!(:report_4) do
    Fabricate(:report)
  end

  context 'grouping associations' do
    it 'returns all associated property cashflow reports' do
      expect(grouping.reports.count).to eq(3)
    end
  end
end
