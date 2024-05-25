unit scmMemberNom;

interface

type



  TMemberNom = class(TObject)
  private
    fSessionID, fMemberID, fDistanceID, fStrokeID, fEventID: Integer;
    FEventStatusID: Integer;
    fTitle, fDescription: string;
    fIsQualified, fIsNominated: boolean;
    procedure writeMemberID(const Value: Integer);

  protected
    procedure writeSessionID(value: Integer);
    procedure writeDistanceID(value: Integer);
    procedure writeStrokeID(value: Integer);
    procedure writeEventID(value: Integer);
    procedure writeEventStatusID(value: Integer);
    procedure writeTitle(value: string);
    procedure writeDescription(value: string);
    procedure writeIsQualified(value: boolean);
    procedure writeIsNominated(value: boolean);
  public
    constructor Create;

//  published
    { published declarations }
    property MemberID: Integer read fMemberID write writeMemberID;
    property SessionID: Integer read fSessionID write writeSessionID;
    property DistanceID: Integer read fDistanceID write writeDistanceID;
    property StrokeID: Integer read fStrokeID write writeStrokeID;
    property EventID: Integer read fEventID write writeEventID;
    property EventStatusID: Integer read fEventStatusID write writeEventStatusID;
    property Title: string read fTitle write writeTitle;
    property Description: string read fDescription write writeDescription;
    property IsQualified: boolean read fIsQualified write writeIsQualified;
    property IsNominated: boolean read fIsNominated write writeIsNominated;

  end;

implementation




{ TMemberNom }

constructor TMemberNom.Create;
begin
  inherited;
	fSessionID := 0;
	fMemberID := 0;
	fDistanceID := 0;
	fStrokeID := 0;
	fEventID := 0;
	fTitle := '';
	fIsQualified := false;
end;

procedure TMemberNom.writeTitle(value: string);
begin
  fTitle := value;
end;

procedure TMemberNom.writeDescription(value: string);
begin
  fDescription := value;
end;

procedure TMemberNom.writeDistanceID(value: Integer);
begin
  fDistanceID := value;
end;

procedure TMemberNom.writeEventID(value: Integer);
begin
  fEventID := value;
end;

procedure TMemberNom.writeEventStatusID(value: Integer);
begin
  fEventStatusID := value;
end;

procedure TMemberNom.writeIsNominated(value: boolean);
begin
  fIsNominated := value;
end;

procedure TMemberNom.writeIsQualified(value: boolean);
begin
  fIsQualified := value;
end;

procedure TMemberNom.writeMemberID(const Value: Integer);
begin
  fMemberID := value;
end;

procedure TMemberNom.writeSessionID(value: Integer);
begin
  fSessionID := value;
end;

procedure TMemberNom.writeStrokeID(value: Integer);
begin
  fStrokeID := value;
end;

end.
