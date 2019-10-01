//// SYUIIcon.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@objcMembers public class SYUIIcon: NSObject {
	public static let none = ""
	public static let ARNavigation = "\u{e10a}"
	public static let ATM = "\u{e314}"
	public static let accomodation = "\u{e34f}"
	public static let add = "\u{e079}"
	public static let ambulance = "\u{e365}"
	public static let amusementPark = "\u{e32d}"
	public static let android = "\u{e2c1}"
	public static let appInfo = "\u{e01a}"
	public static let apple = "\u{e2c0}"
	public static let army = "\u{e369}"
	public static let arrivals = "\u{e323}"
	public static let attraction = "\u{e32c}"
	public static let avoidCongestion = "\u{e28a}"
	public static let avoidCongestionDisabled = "\u{e28b}"
	public static let avoidCountry = "\u{e280}"
	public static let avoidCountryDisabled = "\u{e281}"
	public static let avoidFerry = "\u{e286}"
	public static let avoidFerryDisabled = "\u{e287}"
	public static let avoidHighways = "\u{e284}"
	public static let avoidHighwaysDisabled = "\u{e285}"
	public static let avoidTollRoads = "\u{e282}"
	public static let avoidTollRoadsDisabled = "\u{e283}"
	public static let avoidUnpaved = "\u{e288}"
	public static let avoidUnpavedDisabled = "\u{e289}"
	public static let backAndroid = "\u{e06e}"
	public static let bakery = "\u{e341}"
	public static let bank = "\u{e309}"
	public static let bar = "\u{e348}"
	public static let basketball = "\u{e357}"
	public static let battery = "\u{e023}"
	public static let beach = "\u{e35f}"
	public static let beer = "\u{e346}"
	public static let betterRoute = "\u{e053}"
	public static let bike = "\u{e201}"
	public static let bluetooth = "\u{e2c4}"
	public static let boardOff = "\u{e20d}"
	public static let boardOn = "\u{e20c}"
	public static let boat = "\u{e20a}"
	public static let bookShop = "\u{e33d}"
	public static let borderCrossing = "\u{e327}"
	public static let bus = "\u{e206}"
	public static let cableway = "\u{e326}"
	public static let cafe = "\u{e349}"
	public static let calendar = "\u{e078}"
	public static let call = "\u{e00f}"
	public static let camera = "\u{e07b}"
	public static let camp = "\u{e34e}"
	public static let cancel = "\u{e02f}"
	public static let carAccident = "\u{e24d}"
	public static let carCarrier = "\u{e321}"
	public static let carPosition = "\u{e04b}"
	public static let carRental = "\u{e317}"
	public static let carWash = "\u{e318}"
	public static let caravan = "\u{e34d}"
	public static let card = "\u{e315}"
	public static let cardinal = "\u{e024}"
	public static let casino = "\u{e32e}"
	public static let cemetery = "\u{e307}"
	public static let chateau = "\u{e32a}"
	public static let checkboxChecked = "\u{e009}"
	public static let checkboxEmpty = "\u{e008}"
	public static let church = "\u{e304}"
	public static let cinema = "\u{e332}"
	public static let city = "\u{e059}"
	public static let cityCapital = "\u{e05a}"
	public static let cityCenter = "\u{e056}"
	public static let cityHall = "\u{e308}"
	public static let close = "\u{e004}"
	public static let cloud = "\u{e019}"
	public static let cockpit = "\u{e104}"
	public static let conferenceHall = "\u{e312}"
	public static let contextMenuAndroid = "\u{e002}"
	public static let contextMenuIos = "\u{e001}"
	public static let copyIcon = "\u{e06a}"
	public static let copyIconAndroid = "\u{e06c}"
	public static let court = "\u{e30c}"
	public static let dashcam = "\u{e105}"
	public static let dashcamStop = "\u{e106}"
	public static let delete = "\u{e00b}"
	public static let dentist = "\u{e362}"
	public static let departures = "\u{e324}"
	public static let deviceAndroid = "\u{e022}"
	public static let deviceIphone = "\u{e021}"
	public static let dictation = "\u{e063}"
	public static let dictationDisabled = "\u{e064}"
	public static let directionConnectionL = "\u{e1ba}"
	public static let directionConnectionLBase = "\u{e1bb}"
	public static let directionConnectionR = "\u{e1b3}"
	public static let directionConnectionRBase = "\u{e1b4}"
	public static let directionHighwayExitL = "\u{e1bc}"
	public static let directionHighwayExitR = "\u{e1b5}"
	public static let directionL135 = "\u{e18c}"
	public static let directionL135Base = "\u{e18d}"
	public static let directionL180 = "\u{e18e}"
	public static let directionL45 = "\u{e188}"
	public static let directionL45Base = "\u{e189}"
	public static let directionL90 = "\u{e18a}"
	public static let directionL90Base = "\u{e18b}"
	public static let directionMy = "\u{e240}"
	public static let directionOposite = "\u{e241}"
	public static let directionPin = "\u{e1bf}"
	public static let directionPinBase = "\u{e1c0}"
	public static let directionR135 = "\u{e185}"
	public static let directionR135Base = "\u{e186}"
	public static let directionR180 = "\u{e187}"
	public static let directionR45 = "\u{e181}"
	public static let directionR45Base = "\u{e182}"
	public static let directionR90 = "\u{e183}"
	public static let directionR90Base = "\u{e184}"
	public static let directionRoundExitL = "\u{e1b6}"
	public static let directionRoundExitLBase = "\u{e1b7}"
	public static let directionRoundExitR = "\u{e1af}"
	public static let directionRoundExitRBase = "\u{e1b0}"
	public static let directionRoundL135 = "\u{e1a3}"
	public static let directionRoundL135Base = "\u{e1a4}"
	public static let directionRoundL180 = "\u{e1a5}"
	public static let directionRoundL180Base = "\u{e1a6}"
	public static let directionRoundL225 = "\u{e1a7}"
	public static let directionRoundL225Base = "\u{e1a8}"
	public static let directionRoundL270 = "\u{e1a9}"
	public static let directionRoundL270Base = "\u{e1aa}"
	public static let directionRoundL315 = "\u{e1ab}"
	public static let directionRoundL315Base = "\u{e1ac}"
	public static let directionRoundL360 = "\u{e1ad}"
	public static let directionRoundL360Base = "\u{e1ae}"
	public static let directionRoundL45 = "\u{e19f}"
	public static let directionRoundL45Base = "\u{e1a0}"
	public static let directionRoundL90 = "\u{e1a1}"
	public static let directionRoundL90Base = "\u{e1a2}"
	public static let directionRoundR135 = "\u{e193}"
	public static let directionRoundR135Base = "\u{e194}"
	public static let directionRoundR180 = "\u{e195}"
	public static let directionRoundR180Base = "\u{e196}"
	public static let directionRoundR225 = "\u{e197}"
	public static let directionRoundR225Base = "\u{e198}"
	public static let directionRoundR270 = "\u{e199}"
	public static let directionRoundR270Base = "\u{e19a}"
	public static let directionRoundR315 = "\u{e19b}"
	public static let directionRoundR315Base = "\u{e19c}"
	public static let directionRoundR360 = "\u{e19d}"
	public static let directionRoundR360Base = "\u{e19e}"
	public static let directionRoundR45 = "\u{e18f}"
	public static let directionRoundR45Base = "\u{e190}"
	public static let directionRoundR90 = "\u{e191}"
	public static let directionRoundR90Base = "\u{e192}"
	public static let directionStright = "\u{e180}"
	public static let directionTunnel = "\u{e1bd}"
	public static let directionTunnelBase = "\u{e1be}"
	public static let directionYL = "\u{e1b8}"
	public static let directionYLBase = "\u{e1b9}"
	public static let directionYR = "\u{e1b1}"
	public static let directionYRBase = "\u{e1b2}"
	public static let directions = "\u{e041}"
	public static let directionsAction = "\u{e040}"
	public static let downAndroid = "\u{e071}"
	public static let download = "\u{e017}"
	public static let drugStore = "\u{e363}"
	public static let edit = "\u{e00a}"
	public static let elementarySchool = "\u{e310}"
	public static let email = "\u{e00e}"
	public static let emergencyPhone = "\u{e366}"
	public static let facebook = "\u{e2c6}"
	public static let factory = "\u{e36b}"
	public static let farm = "\u{e36e}"
	public static let fashion = "\u{e33b}"
	public static let fastFood = "\u{e344}"
	public static let fastForward = "\u{e038}"
	public static let featureLocked = "\u{e10b}"
	public static let feedback = "\u{e01e}"
	public static let firefighters = "\u{e367}"
	public static let fitness = "\u{e351}"
	public static let flight = "\u{e325}"
	public static let flowerShop = "\u{e337}"
	public static let fog = "\u{e249}"
	public static let food = "\u{e34b}"
	public static let football = "\u{e356}"
	public static let forest = "\u{e359}"
	public static let forwardAndroid = "\u{e06f}"
	public static let fuelPrices = "\u{e051}"
	public static let fullscreen = "\u{e027}"
	public static let fullscreenExit = "\u{e028}"
	public static let furniture = "\u{e33c}"
	public static let gallery = "\u{e333}"
	public static let globe = "\u{e011}"
	public static let goArrowBottom = "\u{e05f}"
	public static let goArrowLeft = "\u{e05d}"
	public static let goArrowRight = "\u{e006}"
	public static let goArrowTop = "\u{e05e}"
	public static let golf = "\u{e354}"
	public static let google = "\u{e2c5}"
	public static let groceryStore = "\u{e340}"
	public static let HUD = "\u{e103}"
	public static let hamburgerMenu = "\u{e000}"
	public static let harbor = "\u{e36d}"
	public static let history = "\u{e054}"
	public static let home = "\u{e03d}"
	public static let homeNotSet = "\u{e03c}"
	public static let hospital = "\u{e364}"
	public static let house = "\u{e057}"
	public static let iceCreamShop = "\u{e343}"
	public static let info = "\u{e039}"
	public static let infoCenter = "\u{e328}"
	public static let jail = "\u{e36a}"
	public static let jewelery = "\u{e336}"
	public static let kindergarten = "\u{e311}"
	public static let laneAssistL135 = "\u{e1c8}"
	public static let laneAssistL180 = "\u{e1c9}"
	public static let laneAssistL45 = "\u{e1c6}"
	public static let laneAssistL90 = "\u{e1c7}"
	public static let laneAssistR135 = "\u{e1c4}"
	public static let laneAssistR180 = "\u{e1c5}"
	public static let laneAssistR45 = "\u{e1c2}"
	public static let laneAssistR90 = "\u{e1c3}"
	public static let laneAssistStright = "\u{e1c1}"
	public static let library = "\u{e30e}"
	public static let like = "\u{e03a}"
	public static let liked = "\u{e03b}"
	public static let likes = "\u{e077}"
	public static let list = "\u{e003}"
	public static let lock = "\u{e068}"
	public static let map = "\u{e072}"
	public static let money = "\u{e313}"
	public static let moneyExchange = "\u{e316}"
	public static let monument = "\u{e32b}"
	public static let mosque = "\u{e306}"
	public static let motorbike = "\u{e202}"
	public static let mountines = "\u{e35a}"
	public static let museum = "\u{e30a}"
	public static let nearby = "\u{e04e}"
	public static let office = "\u{e30b}"
	public static let offline = "\u{e018}"
	public static let ok = "\u{e02e}"
	public static let opera = "\u{e330}"
	public static let POIPoi = "\u{e075}"
	public static let parfumes = "\u{e33e}"
	public static let park = "\u{e35c}"
	public static let parking = "\u{e31e}"
	public static let parkingHouse = "\u{e31d}"
	public static let paste = "\u{e06b}"
	public static let pasteAndroid = "\u{e06d}"
	public static let patisserie = "\u{e342}"
	public static let peak = "\u{e35b}"
	public static let petStore = "\u{e338}"
	public static let philharmonic = "\u{e32f}"
	public static let photoNavigation = "\u{e109}"
	public static let pin = "\u{e048}"
	public static let pinLiked = "\u{e04a}"
	public static let pinPlace = "\u{e049}"
	public static let pizza = "\u{e34a}"
	public static let places = "\u{e04f}"
	public static let plane = "\u{e20b}"
	public static let playGround = "\u{e35d}"
	public static let poiBorder = "\u{e076}"
	public static let police = "\u{e254}"
	public static let policeStation = "\u{e368}"
	public static let positionAndroid = "\u{e045}"
	public static let positionIos = "\u{e042}"
	public static let positionLockAndroid = "\u{e046}"
	public static let positionLockCompassAndroid = "\u{e047}"
	public static let positionLockCompassIos = "\u{e044}"
	public static let positionLockIos = "\u{e043}"
	public static let postOffice = "\u{e30d}"
	public static let pray = "\u{e300}"
	public static let premium = "\u{e101}"
	public static let presents = "\u{e33f}"
	public static let print = "\u{e07e}"
	public static let prkingOnStreet = "\u{e31c}"
	public static let profile = "\u{e013}"
	public static let publicTransportStop = "\u{e320}"
	public static let pushViewBottom = "\u{e062}"
	public static let pushViewLeft = "\u{e060}"
	public static let pushViewRight = "\u{e005}"
	public static let pushViewTop = "\u{e061}"
	public static let railwayCrossing = "\u{e242}"
	public static let ratingFull = "\u{e01d}"
	public static let ratingHalfLeft = "\u{e01b}"
	public static let ratingHalfRight = "\u{e01c}"
	public static let recording = "\u{e05b}"
	public static let religionChristian = "\u{e301}"
	public static let religionJew = "\u{e302}"
	public static let religionMuslim = "\u{e303}"
	public static let renew = "\u{e067}"
	public static let reportIncident = "\u{e050}"
	public static let restaurant = "\u{e34c}"
	public static let restingArea = "\u{e31f}"
	public static let rewind = "\u{e037}"
	public static let roadBottleneck = "\u{e24a}"
	public static let roadClosure = "\u{e24e}"
	public static let roadWorks = "\u{e24b}"
	public static let rotateDeviceAndroid = "\u{e020}"
	public static let rotateDeviceIos = "\u{e01f}"
	public static let routeStart = "\u{e07f}"
	public static let running = "\u{e353}"
	public static let safari = "\u{e012}"
	public static let save = "\u{e07a}"
	public static let school = "\u{e30f}"
	public static let schoolZone = "\u{e24c}"
	public static let search = "\u{e055}"
	public static let selected = "\u{e007}"
	public static let serviceStation = "\u{e319}"
	public static let settings = "\u{e016}"
	public static let shareAndroid = "\u{e00d}"
	public static let shareIos = "\u{e00c}"
	public static let sharpCurveLeft = "\u{e243}"
	public static let sharpCurveRight = "\u{e244}"
	public static let shoeStore = "\u{e33a}"
	public static let shopping = "\u{e335}"
	public static let ski = "\u{e358}"
	public static let snow = "\u{e247}"
	public static let sosWidget = "\u{e108}"
	public static let soundsAlertsOnly = "\u{e065}"
	public static let soundsHigh = "\u{e033}"
	public static let soundsInstructionsOnly = "\u{e066}"
	public static let soundsLow = "\u{e031}"
	public static let soundsMedium = "\u{e032}"
	public static let soundsOff = "\u{e030}"
	public static let spa = "\u{e350}"
	public static let speedcam = "\u{e24f}"
	public static let speedcamSegmental = "\u{e250}"
	public static let stadium = "\u{e352}"
	public static let stationCharging = "\u{e31a}"
	public static let stationPetrol = "\u{e31b}"
	public static let stop = "\u{e052}"
	public static let stopPlaying = "\u{e035}"
	public static let storageExternal = "\u{e073}"
	public static let store = "\u{e014}"
	public static let street = "\u{e058}"
	public static let streetView = "\u{e05c}"
	public static let stronghold = "\u{e329}"
	public static let subway = "\u{e208}"
	public static let supermarket = "\u{e334}"
	public static let swap = "\u{e07c}"
	public static let swapHorizontal = "\u{e07d}"
	public static let swimming = "\u{e35e}"
	public static let sygic = "\u{e2c3}"
	public static let sygicApp = "\u{e100}"
	public static let sygicTravel = "\u{e102}"
	public static let synagogue = "\u{e305}"
	public static let sync = "\u{e074}"
	public static let taxi = "\u{e204}"
	public static let temperatureLow = "\u{e248}"
	public static let tennis = "\u{e355}"
	public static let terminal = "\u{e322}"
	public static let theater = "\u{e331}"
	public static let thumbDown = "\u{e082}"
	public static let thumbUp = "\u{e081}"
	public static let time = "\u{e080}"
	public static let toilet = "\u{e36f}"
	public static let toyStore = "\u{e339}"
	public static let traffic = "\u{e253}"
	public static let trafficLights = "\u{e252}"
	public static let trafficLightsCam = "\u{e251}"
	public static let train = "\u{e209}"
	public static let tramway = "\u{e207}"
	public static let travelBook = "\u{e107}"
	public static let truck = "\u{e205}"
	public static let uber = "\u{e2c7}"
	public static let unlock = "\u{e069}"
	public static let upAndroid = "\u{e070}"
	public static let vegetables = "\u{e345}"
	public static let vehicle = "\u{e203}"
	public static let vet = "\u{e361}"
	public static let view = "\u{e025}"
	public static let view2D = "\u{e02b}"
	public static let view3D = "\u{e02a}"
	public static let viewControls = "\u{e029}"
	public static let viewNone = "\u{e026}"
	public static let walk = "\u{e200}"
	public static let warehouse = "\u{e36c}"
	public static let warning = "\u{e245}"
	public static let waypointAdd = "\u{e04c}"
	public static let waypointRemove = "\u{e04d}"
	public static let website = "\u{e010}"
	public static let wind = "\u{e246}"
	public static let windows = "\u{e2c2}"
	public static let wine = "\u{e347}"
	public static let work = "\u{e03f}"
	public static let workNotSet = "\u{e03e}"
	public static let zoo = "\u{e360}"
	public static let zoomIn = "\u{e02d}"
	public static let zoomOut = "\u{e02c}"
    
    public static var square: UIImage? { UIImage(named: "square", in: iconsBundle, compatibleWith: nil) }
    public static var play: UIImage? { UIImage(named: "controlsplay", in: iconsBundle, compatibleWith: nil) }
    public static var pause: UIImage? { UIImage(named: "controlspause", in: iconsBundle, compatibleWith: nil) }
    public static var browser: UIImage? { UIImage(named: "browsersafarifull", in: iconsBundle, compatibleWith: nil) }
    public static var getDirection: UIImage? { UIImage(named: "getdirection", in: iconsBundle, compatibleWith: nil) }
    public static var heartFull: UIImage? { UIImage(named: "heartFull", in: iconsBundle, compatibleWith: nil) }
    public static var mailFull: UIImage? { UIImage(named: "mailFull", in: iconsBundle, compatibleWith: nil) }
    public static var phone: UIImage? { UIImage(named: "phone", in: iconsBundle, compatibleWith: nil) }
    public static var pointOnMap: UIImage? { UIImage(named: "pointonmap", in: iconsBundle, compatibleWith: nil) }
    public static var options: UIImage? { UIImage(named: "options", in: iconsBundle, compatibleWith: nil) }
    
    private static var iconsBundle: Bundle {
        return Bundle(for: SYUIIcon.self)
    }
}


