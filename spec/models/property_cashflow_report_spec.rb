require 'rails_helper'

describe PropertyCashflowReport do
  let!(:time_frame) { Fabricate(:time_frame) }
  let!(:grouping) do
    Fabricate(:comparison_grouping,
              time_frame: time_frame)
  end

  let!(:report) do
    Fabricate(:property_cashflow_report,
              comparison_grouping: grouping,
              time_frame: time_frame)
  end

  let!(:expense) { Fabricate(:cashflow_type, time_frame: time_frame) }
  let!(:income) do
    Fabricate(:cashflow_type,
             name: 'realized gain',
             debit: nil,
             credit: true,
             time_frame: time_frame)
  end

  let!(:hoa_fee) do
    Fabricate(:cashflow_item,
              cashflow_type: expense,
              property_cashflow_report: report)
  end

  let!(:rent) do
    Fabricate(:cashflow_item,
              cashflow_type: income,
              property_cashflow_report: report)
  end

  context 'report associations' do
    it 'returns all associated cashflow items' do
      expect(report.cashflow_items).to eq([hoa_fee, rent])
    end

    it 'returns the comparison grouping it is associated with' do
      expect(report.comparison_grouping).to eq(grouping)
    end
  end
end
