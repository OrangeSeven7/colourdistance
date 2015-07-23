require 'spec_helper'

describe "Colourdistance" do
	it "correct ciede2000 top bounds" do
    expect(1.0).to eq Colourdistance.ciede2000({r: 0.0, g: 0.0, b: 0.0},{r: 255.0, g: 255.0, b: 255.0}).round(1)
  end

  it "correct ciede2000 bottom bounds" do
    expect(0.0).to eq Colourdistance.ciede2000({r: 0.0, g: 0.0, b: 0.0},{r: 0.0, g: 0.0, b: 0.0}).round(1)
  end

  it "correct ciede94 top bounds" do
    expect(1.0).to eq Colourdistance.ciede94({r: 0.0, g: 0.0, b: 0.0},{r: 255.0, g: 255.0, b: 255.0}).round(1)
  end

  it "correct ciede94 bottom bounds" do
    expect(0.0).to eq Colourdistance.ciede94({r: 0.0, g: 0.0, b: 0.0},{r: 0.0, g: 0.0, b: 0.0}).round(1)
  end
end