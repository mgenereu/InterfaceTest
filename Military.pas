unit Military;

interface

type
  IBlaster = interface
    ['{1963A285-DD73-4926-8488-69A09457CCAF}']
    procedure Fire(const ADirection: String);
  end;

  ILoadable = interface(IInterface)
  ['{CE453C89-D415-4246-A8D4-3E8EF68B2AFC}']
    procedure LoadAmmo(const Count: Integer);
  end;

  TCannon = class(TInterfacedObject, ILoadable, IBlaster)
  strict private
    FClip: Integer;
  public
    constructor Create;
    procedure Fire(const ADirection: String);
    procedure LoadAmmo(const Count: Integer);
  end;

  TCatapult = class(TInterfacedObject, ILoadable, IBlaster)
  strict private
    FClip: Integer;
  public
    constructor Create;
    procedure Fire(const ADirection: String);
    procedure LoadAmmo(const Count: Integer);
  end;

  TMilitary = class
  strict private
    FCannonBlaster: IBlaster;
    FCannonLoadable: ILoadable;
    FCatapultBlaster: IBlaster;
    FCatapultLoadable: ILoadable;
  private
    procedure UseTheCannon;
    procedure UseTheCatapult;
  public
    constructor Create;
    procedure KillTheEnemy;
  end;

implementation

uses
  System.SysUtils;

type
  TSoldierFiveShooter = class
  strict private
    FBlaster: IBlaster;
  public
    constructor Create(ABlaster: IBlaster);
    procedure Attack;
  end;

  TSoldierFourLoader = class
  strict private
    FLoadable: ILoadable;
  public
    constructor Create(ALoadable: ILoadable);
    procedure Load;
  end;

  TSoldierOneLoader = class
  strict private
    FLoadable: ILoadable;
  public
    constructor Create(ALoadable: ILoadable);
    procedure Load;
  end;

  TSoldierTwoShooter = class
  strict private
    FBlaster: IBlaster;
  public
    constructor Create(ABlaster: IBlaster);
    procedure Attack;
  end;

constructor TSoldierFiveShooter.Create(ABlaster: IBlaster);
begin
  inherited Create;
  FBlaster := ABlaster;
end;

procedure TSoldierFiveShooter.Attack;
begin
  FBlaster.Fire('North');
  FBlaster.Fire('South');
  FBlaster.Fire('East');
  FBlaster.Fire('West');
  FBlaster.Fire('Up');
end;

constructor TSoldierFourLoader.Create(ALoadable: ILoadable);
begin
  inherited Create;
  FLoadable := ALoadable;
end;

procedure TSoldierFourLoader.Load;
begin
  FLoadable.LoadAmmo(4);
end;

procedure TMilitary.UseTheCannon;
var
  Loader: TSoldierFourLoader;
  Shooter: TSoldierFiveShooter;
begin
  Loader := TSoldierFourLoader.Create(FCannonLoadable);
  Shooter := TSoldierFiveShooter.Create(FCannonBlaster);
  try
    Loader.Load;
    Shooter.Attack;
  finally
    Shooter.Free;
    Loader.Free;
  end;
end;

procedure TMilitary.UseTheCatapult;
var
  Loader: TSoldierOneLoader;
  Shooter: TSoldierTwoShooter;
begin
  Loader := TSoldierOneLoader.Create(FCatapultLoadable);
  Shooter := TSoldierTwoShooter.Create(FCatapultBlaster);
  try
    Loader.Load;
    Shooter.Attack;
  finally
    Shooter.Free;
    Loader.Free;
  end;
end;

constructor TMilitary.Create;
var
  LCannon: TCannon;
  LCatapult: TCatapult;
begin
  inherited Create;
  LCannon := TCannon.Create();
  FCannonLoadable := LCannon;
  FCannonBlaster := LCannon;

  LCatapult := TCatapult.Create();
  FCatapultLoadable := LCatapult;
  FCatapultBlaster := LCatapult;
end;

procedure TMilitary.KillTheEnemy;
begin
  UseTheCannon;
  UseTheCatapult;
  UseTheCannon;
end;

constructor TCannon.Create;
begin
  inherited Create;
  FClip := 0;
end;

procedure TCannon.Fire(const ADirection: String);
begin
  if FClip > 0 then
  begin
    WriteLn('Firing: Pew! Pew! to the ' + ADirection);
    Dec(FClip);
  end
  else
  begin
    WriteLn('Fireing: Click. Click.');
  end;
end;

procedure TCannon.LoadAmmo(const Count: Integer);
begin
  FClip := FClip + Count;
  WriteLn('Added: ' + Count.ToString);
end;

constructor TCatapult.Create;
begin
  inherited Create;
  FClip := 0;
end;

procedure TCatapult.Fire(const ADirection: String);
begin
  if FClip > 0 then
  begin
    WriteLn('Firing: Swish to the ' + ADirection);
    Dec(FClip);
  end
  else
  begin
    WriteLn('Fireing: Silence');
  end;
end;

procedure TCatapult.LoadAmmo(const Count: Integer);
begin
  FClip := FClip + Count;
  WriteLn('Added: ' + Count.ToString);
end;

constructor TSoldierOneLoader.Create(ALoadable: ILoadable);
begin
  inherited Create;
  FLoadable := ALoadable;
end;

procedure TSoldierOneLoader.Load;
begin
  FLoadable.LoadAmmo(1);
end;

constructor TSoldierTwoShooter.Create(ABlaster: IBlaster);
begin
  inherited Create;
  FBlaster := ABlaster;
end;

procedure TSoldierTwoShooter.Attack;
begin
  FBlaster.Fire('North');
  FBlaster.Fire('South');
end;

end.
