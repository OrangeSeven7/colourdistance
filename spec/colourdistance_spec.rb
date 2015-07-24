require 'spec_helper'

describe "Colourdistance" do
	it "correct ciede2000 top bounds" do
    expect(1.000).to eq Colourdiff.ciede2000({r: 0.0, g: 0.0, b: 0.0},{r: 255.0, g: 255.0, b: 255.0}).round(3)
  end

  it "correct ciede2000 bottom bounds" do
    expect(0.000).to eq Colourdiff.ciede2000({r: 0.0, g: 0.0, b: 0.0},{r: 0.0, g: 0.0, b: 0.0}).round(3)
  end
end