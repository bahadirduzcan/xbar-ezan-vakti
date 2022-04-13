#!/usr/bin/ruby

require 'net/http'
require 'json'
require 'time'



def valid_json?(string)
  !!JSON.parse(string)
rescue JSON::ParserError
  false
end

def vakitHesapla(time)
	prayerT = time.split(':')
	today = ((Time.new.hour * 60) + Time.new.min)
	prayerTime = ((prayerT[0].to_i * 60) + prayerT[1].to_i)
	return (prayerTime - today).to_i
end

begin
	url = 'https://prayer.bahadirduzcan.com.tr/?data=true&regionId=9726'
	uri = URI(url)
	response = Net::HTTP.get(uri)
rescue SocketError
	puts '🚫'
	puts '---'
	puts 'İnternet bağlantısı yok.'
	exit
end
if valid_json?(response)
	vakitler = JSON.parse(response)

	str = "🕌 \n" << "---\n"

	str << "%-10s " % "Tarih  : #{vakitler[0]["Tarih"]} " << "|font=Menlo size=18 color=blue \n"

	imsakColor = "red"
	gunesColor = "red"
	ogleColor = "red"
	ikindiColor = "red"
	aksamColor = "red"
	yatsiColor = "red"

	if vakitHesapla(vakitler[0]["Yatsi"]) < 0
		imsakColor = "red"
		gunesColor = "red"
		ogleColor = "red"
		ikindiColor = "red"
		aksamColor = "red"
		yatsiColor = "green"
	elsif vakitHesapla(vakitler[0]["Aksam"]) < 0
		imsakColor = "red"
		gunesColor = "red"
		ogleColor = "red"
		ikindiColor = "red"
		aksamColor = "green"
		yatsiColor = "red"
	elsif vakitHesapla(vakitler[0]["Ikindi"]) < 0
		imsakColor = "red"
		gunesColor = "red"
		ogleColor = "red"
		ikindiColor = "green"
		aksamColor = "red"
		yatsiColor = "red"
	elsif vakitHesapla(vakitler[0]["Ogle"]) < 0
		imsakColor = "red"
		gunesColor = "red"
		ogleColor = "green"
		ikindiColor = "red"
		aksamColor = "red"
		yatsiColor = "red"
	elsif vakitHesapla(vakitler[0]["Gunes"]) < 0
		imsakColor = "red"
		gunesColor = "green"
		ogleColor = "red"
		ikindiColor = "red"
		aksamColor = "red"
		yatsiColor = "red"
	elsif vakitHesapla(vakitler[0]["Imsak"]) < 0
		imsakColor = "green"
		gunesColor = "red"
		ogleColor = "red"
		ikindiColor = "red"
		aksamColor = "red"
		yatsiColor = "red"
	else
		imsakColor = "red"
		gunesColor = "red"
		ogleColor = "red"
		ikindiColor = "red"
		aksamColor = "red"
		yatsiColor = "red"
	end

	str << "%-10s " % "İmsak   : #{vakitler[0]["Imsak"]} " << "|font=Menlo size=18 color=#{imsakColor} \n"
	str << "%-10s " % "Güneş   : #{vakitler[0]["Gunes"]} " << "|font=Menlo size=18 color=#{gunesColor} \n"
	str << "%-10s " % "Öğle    : #{vakitler[0]["Ogle"]} " << "|font=Menlo size=18 color=#{ogleColor} \n"
	str << "%-10s " % "İkindi  : #{vakitler[0]["Ikindi"]} " << "|font=Menlo size=18 color=#{ikindiColor} \n"
	str << "%-10s " % "Akşam   : #{vakitler[0]["Aksam"]} " << "|font=Menlo size=18 color=#{aksamColor} \n"
	str << "%-10s " % "Yatsı   : #{vakitler[0]["Yatsi"]} " << "|font=Menlo size=18 color=#{yatsiColor} \n"

	puts str
else
	puts '🚫'
	puts '---'
	puts 'Veri alınamıyor.'
end