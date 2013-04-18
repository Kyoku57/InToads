require 'rest_client'
require "json"

race = [[6.536392660,48.352559260],[6.536433060,48.352347200],[6.538022780,48.351390490],[6.538739600,48.350656240],[6.537983550,48.350185340],[6.537002870,48.349779830],[6.536391990,48.349686620],[6.535678360,48.349386550],[6.535446680,48.349114970],[6.535597220,48.348235040],[6.535681370,48.347445800],[6.534786350,48.346396550],[6.534090150,48.345989030],[6.533563100,48.345300200],[6.532837730,48.344343160],[6.531885550,48.343315700],[6.531212140,48.342455050],[6.531076520,48.342233930],[6.531182300,48.342082720],[6.531478520,48.341914920],[6.531913210,48.341820870],[6.532446130,48.341664300],[6.532802690,48.341513930],[6.532935460,48.341332380],[6.535638460,48.341029620],[6.536249840,48.339828490],[6.536433570,48.338996340],[6.536319740,48.338312380],[6.536244810,48.337745090],[6.536757440,48.337520450],[6.537088030,48.337046710],[6.538312290,48.336138110],[6.539935190,48.335063050],[6.540492250,48.334720560],[6.541165820,48.334320080],[6.542602480,48.333381640],[6.543058960,48.333042670],[6.545902940,48.330051000],[6.547074560,48.328826240],[6.547159890,48.328634970],[6.547527850,48.328447210],[6.547531710,48.328245380],[6.548851690,48.326612080],[6.549571700,48.325537690],[6.549876630,48.325069810],[6.550348870,48.324676530],[6.553115730,48.322991260],[6.553708670,48.322593630],[6.554038580,48.321936650],[6.554643590,48.321189150],[6.554932760,48.320775420],[6.554855310,48.320388350],[6.555182210,48.319755010],[6.556082760,48.319050600],[6.556617360,48.318493700],[6.557664590,48.317733630],[6.559140640,48.317294250],[6.560533380,48.316757140],[6.566866080,48.316563350],[6.568123360,48.316535020],[6.568935400,48.316606600],[6.570866760,48.316503500],[6.572997770,48.316376430],[6.573799760,48.316011480],[6.575885170,48.315633960],[6.579097790,48.314863000],[6.581997930,48.313968650],[6.585925690,48.313322910],[6.587582620,48.312322110],[6.589409880,48.310626280],[6.590514610,48.309342840],[6.591003950,48.308854680],[6.591158010,48.307958490],[6.592313540,48.306370790],[6.593509970,48.305285830],[6.592800020,48.305227330],[6.592056040,48.304750230],[6.591213660,48.304612600],[6.588593140,48.304908980],[6.585709940,48.305382730],[6.584427000,48.305714650],[6.583272480,48.305453810],[6.582689430,48.305407710],[6.582048720,48.305582050],[6.581095700,48.305633180],[6.580407540,48.305842900],[6.578901320,48.306216390],[6.577875710,48.306303730],[6.576385070,48.306559040],[6.575624160,48.306804970],[6.574111900,48.306792230],[6.573215370,48.306605980],[6.571955570,48.306600950],[6.571267410,48.306188730],[6.570937500,48.305847760],[6.569696810,48.305455480],[6.569656250,48.304952900],[6.569861940,48.304693400],[6.569733860,48.304042800],[6.570326630,48.302962870],[6.571158450,48.301101420],[6.571296420,48.300004230],[6.571110510,48.299573900],[6.571480480,48.298854900],[6.571562790,48.298314270],[6.571075640,48.297894840],[6.570735160,48.296798150],[6.570907330,48.294254580],[6.572000830,48.293139950],[6.572374830,48.292471080],[6.572307110,48.291633390],[6.571452990,48.290723120],[6.570414980,48.289718630],[6.568974630,48.289031140],[6.567878280,48.288549690],[6.568012050,48.288023970],[6.568902380,48.287202210],[6.570216830,48.286331500],[6.570304500,48.285857920],[6.569907030,48.285300860],[6.569517780,48.284844380],[6.569483910,48.284425460],[6.568690990,48.283647450],[6.568079780,48.283249310],[6.567398660,48.282920900],[6.565488430,48.281712570],[6.564777810,48.281015530],[6.564254110,48.280765580],[6.564030980,48.280185390],[6.564187220,48.279625310],[6.563900560,48.278879490],[6.563695540,48.277273680],[6.563211570,48.276266010],[6.561632080,48.276658780],[6.559835000,48.277160360],[6.558540000,48.277021890],[6.557124960,48.276955000],[6.554772670,48.277442660],[6.551958190,48.277190700],[6.550781880,48.279467730],[6.544613630,48.277890590],[6.540980250,48.278726100],[6.541595140,48.280115650],[6.542305590,48.281753810],[6.542257480,48.282410780],[6.541799330,48.283603360],[6.541859000,48.284659810],[6.542002000,48.284873220],[6.540468280,48.285213690],[6.539420710,48.285335060],[6.537794620,48.285779640],[6.536853670,48.285661950],[6.536707490,48.286036790],[6.534025280,48.288384060],[6.533412730,48.288910110],[6.532651650,48.290096650],[6.531399730,48.290813300],[6.530801600,48.291204400],[6.528668240,48.293179010],[6.526936030,48.294820190],[6.525577830,48.296414430],[6.524218790,48.297370130],[6.522772740,48.299757130],[6.521863640,48.300041610],[6.521270870,48.300818780],[6.519636570,48.301481790],[6.519763640,48.303073510],[6.518632250,48.303096820],[6.517348980,48.303428070],[6.515798660,48.303567210],[6.515592630,48.303826540],[6.515801010,48.304860870],[6.515424160,48.306134420],[6.515190300,48.306361230],[6.512172990,48.307056260],[6.511082840,48.307599070],[6.512728710,48.309288190],[6.515319220,48.313346370],[6.516809690,48.315292990],[6.516559570,48.316578940],[6.516729390,48.317127280],[6.515885000,48.319173640],[6.516372650,48.320550960],[6.518690750,48.322131950],[6.519282180,48.322598320],[6.526157860,48.324773420],[6.530120150,48.325170060],[6.525915620,48.327902890],[6.525552350,48.328283260],[6.525469200,48.329703990],[6.528238910,48.332335910],[6.528863530,48.332759870],[6.529979170,48.334400540],[6.530027450,48.335002530],[6.529848410,48.335717840],[6.530248060,48.336487970],[6.530308910,48.337864280],[6.529530400,48.339204550],[6.529353040,48.340064190],[6.530028450,48.341123000],[6.530561370,48.341629260],[6.532566160,48.341341430],[6.529321190,48.342097640],[6.527319590,48.342540380],[6.523602550,48.343402870],[6.521936730,48.343961780],[6.519141870,48.345303720],[6.517193080,48.346410640],[6.512217910,48.348854800],[6.509243850,48.349882590],[6.506832370,48.350736700],[6.506735650,48.350970730],[6.506152100,48.351606410],[6.506197860,48.352181240],[6.507639550,48.353629130],[6.509846000,48.355024380],[6.510768850,48.355990980],[6.510998180,48.357661330],[6.511263210,48.358574290],[6.511232030,48.360007930],[6.511488180,48.360959780],[6.511980200,48.362108770],[6.512345820,48.363799730],[6.513944420,48.362871860],[6.514344570,48.362345140],[6.515873260,48.361266050],[6.516623610,48.360791130],[6.517037000,48.360430540],[6.518024220,48.359793350],[6.519034240,48.358719630],[6.520363450,48.358031980],[6.522402260,48.356844930],[6.523322760,48.356094750],[6.524108310,48.354862440],[6.524406880,48.354749460],[6.526186520,48.354647700],[6.526390200,48.354550800],[6.527361830,48.354682740],[6.528452150,48.354374950],[6.529150200,48.354209160],[6.530628430,48.354425580],[6.531481710,48.354279900],[6.532040780,48.353581020],[6.532360300,48.353249260],[6.532882660,48.353051450],[6.534311940,48.352897890],[6.535447690,48.352678120],[6.536199380,48.352702600]]
team1 = ["SDE","AAA","CTN","MBR","WTI"]
altStart = 200

def sendNotif(url,data)
  ["http://localhost:9000"].each do|srv|
    begin
      RestClient.post srv+url, data.to_json, :content_type => :json
    rescue
    end
  end
end

def lap(startOrEnd,rider,pos,alti)
  sendNotif(
    "/lap/#{startOrEnd}/#{rider}",
    {
      :lat => pos[1],
      :long => pos[0],
      :alti => alti,
      :time => Time.now.to_i
    }
  )
end

def position(rider,pos,alti)
  sendNotif(
    "/position/#{rider}",
    {
      :lat => pos[1],
      :long => pos[0],
      :alti => alti,
      :time => Time.now.to_i
    }
  )
end

idxPos  =0
idxRider=0

alt = altStart
lap("start",team1[idxRider],race[0],alt)
while true
  alt = alt + rand(-10..10)
  rider = team1[idxRider]
  pos = race[idxPos]
  idxPos=idxPos+1
  if idxPos>= race.size 
    lap("end",rider,pos,alt)
    alt = altStart
    idxPos=0
    idxRider=idxRider+1
    if idxRider>=team1.size
      idxRider=0
    end
    lap("start",team1[idxRider],race[0],altStart)
  end
  position(rider,pos,alt)
  sleep rand(0.5..5.0)
end