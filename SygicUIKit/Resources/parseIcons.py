import fontforge # requires fontforge package installation - brew install fontforge

categoriesRelativePath = "../Classes/Helpers/Utils/"
fontFile = fontforge.open("SygicIcons.ttf", 4) 
icons = []

for (i, glyph) in enumerate(fontFile.glyphs()):
	name = glyph.glyphname
	if name.startswith('.') or name.startswith('uniE') or hex(glyph.unicode).startswith('-0x1') or "NULL" == name or "space" == name or "nonmarkingreturn" == name:
		continue

	icon = [glyph.glyphname, hex(glyph.unicode)]
	icons.append(icon)

icons.sort()


# swift file


sFile = open(categoriesRelativePath + "SygicIcons.swift","w")

# class & constants for legacy ObjC code

sFile.write("@objcMembers public class SygicIcon: NSObject {\n")

#empty icon
sFile.write("\tpublic static let none = \"\"\n")

for (i, glyph) in enumerate(icons):
    name = glyph[0]
    if name[0].isupper() and name[1].islower():
        name = name[0].lower()+name[1:]
    name = name.replace("copy", "copyIcon")
    code = glyph[1].replace("0x", "\\u{")
    sFile.write("\tpublic static let {} = \"{}}}\"\n".format(name,code))


sFile.write("}\n\n\n")

# enum for the future

# sFile.write("//enum SygicIcon: String {\n")

# for (i, glyph) in enumerate(icons):
#     name = glyph[0]
#     if name[0].isupper() and name[1].islower():
#         name = name[0].lower()+name[1:]
#     code = glyph[1].replace("0x", "\u{")
#     sFile.write("//\tcase {} = \"{}}}\"\n".format(name,code))

# sFile.write("//}")
# sFile.close()


# html file


htmlFile = open("icons.html","w")
htmlFile.write("""<html>
    <head>
    <style type="text/css">
    @font-face {
    font-family: 'SygicIcons';
    src: url('SygicIcons.ttf');
    }
    body {text-align: center;}
    .item {display: inline-block; border:1px solid #eee; margin: 2px 0px; padding: 5px 10px; height:150px; width:150px; text-align: center; font-family: "OpenSans", sans-serif; color:#888; transition: ease 0.25s;}
    .item:hover {background: #eee;}
    .item strong {display: block; max-height: 20px; color:#444; white-space: pre-wrap; word-wrap: break-word;}
    .icon {display: inline-block; min-height: 70px; padding-bottom: 10px; font-family: "SygicIcons"; font-size:70px; color:#444;}
    
    </style>
    </head>
    <body>""")
for (i, glyph) in enumerate(icons):
    htmlFile.write(u"<div class=\"item\"><span class=\"icon\">{}</span><strong>{}</strong><br/>{}</div>\n".format(glyph[1].replace("0x", "&#x"),glyph[0],glyph[1]))

htmlFile.write("""</table>
    </body>
    </html>""")

htmlFile.close()


# Icon for POI mapping


#        @"_grp.Tourism": @(IconAttraction),
#        @"_poi.Tourist_Information_Office": @(IconInfoCenter),
#        @"_poi.Museum": @(IconMuseum),
#        @"_poi.Travel_Agency": @(IconAttraction),
#        @"_poi.Zoo": @(IconZoo),
#        @"_poi.Scenic_Panoramic_View": @(IconMountines),
#        @"_poi.Camping_Ground": @(IconCamp),
#        @"_poi.Caravan_Site": @(IconCaravan),
#        @"_poi.Recreation_Facility": @(IconSpa),
#        @"_poi.Beach": @(IconBeach),
#        @"_poi.Mountain_Peak": @(IconPeak),
#        @"_poi.Natives_Reservation": @(IconAttraction),
#        @"_poi.Building_Footprint": @(IconAttraction),
#        @"_poi.Castle": @(IconChateau),
#        @"_poi.Fortress": @(IconStronghold),
#        @"_poi.Holiday_Area": @(IconBeach),
#        @"_poi.Lighthouse": @(IconAttraction),
#        @"_poi.Monument": @(IconMonument),
#        @"_poi.Natural_Reserve": @(IconForest),
#        @"_poi.Rocks": @(IconAttraction),
#        @"_poi.Walking_Area": @(IconAttraction),
#        @"_poi.Water_Mill": @(IconAttraction),
#        @"_poi.Windmill": @(IconAttraction),
#        @"_poi.Mountain_Pass": @(IconMountines),
#        @"_poi.Archeology": @(IconAttraction),
#        @"_poi.Important_Tourist_Attraction": @(IconAttraction),
#        @"_poi.Park_and_Recreation_Area": @(IconPark),
#        @"_poi.Forest_Area": @(IconForest),
#        @"_grp.Food_and_Drink": @(IconFood),
#        @"_poi.Winery": @(IconWine),
#        @"_poi.Road_Side_Diner": @(IconFood),
#        @"_poi.Restaurant_Area": @(IconRestaurant),
#        @"_poi.Cafe_Pub": @(IconCafe),
#        @"_poi.Pastry_and_Sweets": @(IconPatisserie),
#        @"_poi.Restaurant": @(IconRestaurant),
#        @"_poi.Food": @(IconFood),
#        @"_grp.Accomodation": @(IconAccomodation),
#        @"_poi.Hotel_or_Motel": @(IconAccomodation),
#        @"_grp.Parking": @(IconParking),
#        @"_poi.Coach_and_Lorry_Parking": @(IconParking),
#        @"_poi.Rent_a_Car_Parking": @(IconCarRental),
#        @"_poi.Parking_Garage": @(IconParkingHouse),
#        @"_poi.Open_Parking_Area": @(IconParking),
#        @"_grp.Petrol_Station": @(IconStationPetrol),
#        @"_poi.Petrol_Station": @(IconStationPetrol),
#        @"_grp.Transportation": @(IconPlane),
#        @"_poi.Ski_Lift_Station": @(IconCableway),
#        @"_poi.Car_Shipping_Terminal": @(IconCarCarrier),
#        @"_poi.Airport": @(IconPlane),
#        @"_poi.Bus_Station": @(IconBus),
#        @"_poi.Port": @(IconHarbor),
#        @"_poi.Ferry_Terminal": @(IconBoat),
#        @"_poi.Airline_Access": @(IconTerminal),
#        @"_poi.Railway_Station": @(IconTrain),
#        @"_poi.Public_Transport_Stop": @(IconPublicTransportStop),
#        @"_poi.Metro": @(IconSubway),
#        @"_grp.BankATM": @(IconMoney),
#        @"_poi.Bank": @(IconBank),
#        @"_poi.ATM": @(IconATM),
#        @"_grp.Shopping": @(IconShopping),
#        @"_poi.Departement_Store": @(IconSupermarket),
#        @"_poi.Warehouse": @(IconWarehouse),
#        @"_poi.Shopping_Centre": @(IconShopping),
#        @"_poi.Hair_And_Beauty": @(IconShopping),
#        @"_poi.Groceries": @(IconGroceryStore),
#        @"_poi.Mobile_Shop": @(IconDeviceIphone),
#        @"_poi.Shop": @(IconShopping),
#        @"_poi.Supermarket": @(IconSupermarket),
#        @"_poi.Accessories/Furniture": @(IconFurniture),
#        @"_poi.Books_Cards": @(IconBookShop),
#        @"_poi.Childrens_Fashion": @(IconFashion),
#        @"_poi.Children_Toys": @(IconToyStore),
#        @"_poi.Cosmetics_Perfumes": @(IconParfumes),
#        @"_poi.Electronics_Mobiles": @(IconDeviceIphone),
#        @"_poi.Fashion_Mixed": @(IconFashion),
#        @"_poi.Fashion_Accessories": @(IconFashion),
#        @"_poi.Traditional_Fashion": @(IconFashion),
#        @"_poi.Gifts_Antiques": @(IconPresents),
#        @"_poi.Jewellery_Watches": @(IconJewelery),
#        @"_poi.Ladies_Fashion": @(IconFashion),
#        @"_poi.Lifestyle_Fitness": @(IconFitness),
#        @"_poi.Men\'s_Fashion": @(IconFashion),
#        @"_poi.Opticians_Sunglasses": @(IconShopping),
#        @"_poi.Shoes_Bags": @(IconShoeStore),
#        @"_poi.Sports": @(IconRunning),
#        @"_grp.Vehicle_Services": @(IconVehicle),
#        @"_poi.TrafficLights": @(IconTrafficLights),
#        @"_poi.Rent_a_Car_Facility": @(IconCarRental),
#        @"_poi.Motoring_Organization_Office": @(IconVehicle),
#        @"_poi.Bovag_Garage": @(IconParkingHouse),
#        @"_poi.Vehicle_Equipment_Provider": @(IconServiceStation),
#        @"_poi.Rest_Area": @(IconRestingArea),
#        @"_poi.Park_And_Ride": @(IconParking),
#        @"_poi.Car_Repair_Facility": @(IconServiceStation),
#        @"_poi.Car_Dealer": @(IconVehicle),
#        @"_poi.Speed_Cameras": @(IconSpeedcam),
#        @"_poi.Car_Services": @(IconVehicle),
#        @"_poi.Chevrolet_car_dealer": @(IconVehicle),
#        @"_poi.Chevrolet_car_repair": @(IconServiceStation),
#        @"_grp.Social_Life": @(IconTheater),
#        @"_poi.Theatre": @(IconTheater),
#        @"_poi.Cultural_Centre": @(IconTheater),
#        @"_poi.Casino": @(IconCasino),
#        @"_poi.Cinema": @(IconCinema),
#        @"_poi.Opera": @(IconOpera),
#        @"_poi.Concert_Hall": @(IconPhilharmonic),
#        @"_poi.Music_Centre": @(IconPhilharmonic),
#        @"_poi.Leisure_Centre": @(IconSpa),
#        @"_poi.Nightlife": @(IconBar),
#        @"_poi.General": @(IconPinPlace),
#        @"_poi.Entertainment": @(IconTheater),
#        @"_poi.Abbey": @(IconChurch),
#        @"_poi.Amusement_Park": @(IconAmusementPark),
#        @"_poi.Arts_Centre": @(IconGallery),
#        @"_poi.Church": @(IconChurch),
#        @"_poi.Library": @(IconLibrary),
#        @"_poi.Monastery": @(IconChurch),
#        @"_poi.Ecotourism_Sites": @(IconForest),
#        @"_poi.Hunting_Shop": @(IconSupermarket),
#        @"_poi.Kids_Place": @(IconPlayGround),
#        @"_poi.Mosque": @(IconMosque),
#        @"_poi.Place_of_Worship": @(IconPray),
#        @"_grp.Services_and_Education": @(IconSchool),
#        @"_poi.City_Hall": @(IconCityHall),
#        @"_poi.Post_Office": @(IconPostOffice),
#        @"_poi.Public_Phone": @(IconCall),
#        @"_poi.Transport_Company": @(IconTruck),
#        @"_poi.Cargo_Centre": @(IconWarehouse),
#        @"_poi.Community_Centre": @(IconOffice),
#        @"_poi.Customs": @(IconBorderCrossing),
#        @"_poi.Embassy": @(IconCityHall),
#        @"_poi.Frontier_Crossing": @(IconBorderCrossing),
#        @"_poi.School": @(IconElementarySchool),
#        @"_poi.Toll": @(IconAvoidTollRoads),
#        @"_poi.College_University": @(IconSchool),
#        @"_poi.Business_Facility": @(IconOffice),
#        @"_poi.Exhibition_Centre": @(IconOffice),
#        @"_poi.Kindergarten": @(IconKindergarten),
#        @"_poi.Freeport": @(IconPinPlace),
#        @"_poi.Company": @(IconPinPlace),
#        @"_poi.Courthouse": @(IconCourt),
#        @"_poi.Convention_Centre": @(IconConferenceHall),
#        @"_poi.Condominium": @(IconCity),
#        @"_poi.Commercial_Building": @(IconCity),
#        @"_poi.Industrial_Building": @(IconFactory),
#        @"_poi.Cemetery": @(IconCemetery),
#        @"_poi.Factory_Ground_Philips": @(IconFactory),
#        @"_poi.Military_Cemetery": @(IconCemetery),
#        @"_poi.Prison": @(IconJail),
#        @"_poi.State_Police_Office": @(IconPoliceStation),
#        @"_poi.Government_Office": @(IconOffice),
#        @"_poi.Agricultural_Industry": @(IconFarm),
#        @"_poi.Construction": @(IconPinPlace),
#        @"_poi.Factories": @(IconFactory),
#        @"_poi.Media": @(IconPinPlace),
#        @"_poi.Medical_Material": @(IconDrugStore),
#        @"_poi.Personal_Services": @(IconProfile),
#        @"_poi.Professionals": @(IconPinPlace),
#        @"_poi.Real_Estate": @(IconCity),
#        @"_poi.Services": @(IconPinPlace),
#        @"_poi.Border_Point": @(IconBorderCrossing),
#        @"_poi.Exchange": @(IconMoneyExchange),
#        @"_poi.Money_Transfer": @(IconMoneyExchange),
#        @"_poi.Squares": @(IconPinPlace),
#        @"_poi.Local_Names": @(IconPinPlace),
#        @"_poi.Military_Installation": @(IconArmy),
#        @"_poi.Cash_Dispenser": @(IconMoney),
#        @"_grp.Sport": @(IconRunning),
#        @"_poi.Sports_Centre": @(IconStadium),
#        @"_poi.Stadium": @(IconStadium),
#        @"_poi.Hippodrome": @(IconStadium),
#        @"_poi.Ice_Skating_Rink": @(IconRunning),
#        @"_poi.Tennis_Court": @(IconTennis),
#        @"_poi.Skating_Rink": @(IconRunning),
#        @"_poi.Water_Sport": @(IconSwimming),
#        @"_poi.Yacht_Basin": @(IconHarbor),
#        @"_poi.Golf_Course": @(IconGolf),
#        @"_poi.Sports_Hall": @(IconStadium),
#        @"_poi.Car_Racetrack": @(IconStadium),
#        @"_poi.Swimming_Pool": @(IconSwimming),
#        @"_grp.Guides": @(IconInfoCenter),
#        @"_poi.Wikipedia": @(IconInfoCenter),
#        @"_grp.Emergency": @(IconHospital),
#        @"_poi.Hospital_Polyclinic": @(IconHospital),
#        @"_poi.Police_Station": @(IconPoliceStation),
#        @"_poi.First_Aid_Post": @(IconAmbulance),
#        @"_poi.Pharmacy": @(IconDrugStore),
#        @"_poi.Emergency_Call_Station": @(IconEmergencyPhone),
#        @"_poi.Emergency_Medical_Service": @(IconAmbulance),
#        @"_poi.Fire_Brigade": @(IconFirefighters),
#        @"_poi.Doctor": @(IconHospital),
#        @"_poi.Dentist": @(IconDentist),
#        @"_poi.Veterinarian": @(IconVet),
#        @"_poi.Breakdown_Service": @(IconServiceStation)
