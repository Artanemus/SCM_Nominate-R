object SCM: TSCM
  OnCreate = DataModuleCreate
  Height = 870
  Width = 717
  object scmConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_SwimClubMeet')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object tblSwimClub: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SwimClubID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.UpdateTableName = 'SwimClubMeet..SwimClub'
    UpdateOptions.KeyFields = 'SwimClubID'
    TableName = 'SwimClubMeet..SwimClub'
    Left = 48
    Top = 120
    object tblSwimClubSwimClubID: TFDAutoIncField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tblSwimClubCaption: TWideStringField
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object tblSwimClubNickName: TWideStringField
      FieldName = 'NickName'
      Origin = 'NickName'
      Size = 128
    end
    object tblSwimClubEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'Email'
      Size = 128
    end
    object tblSwimClubContactNum: TWideStringField
      FieldName = 'ContactNum'
      Size = 30
    end
    object tblSwimClubWebSite: TWideStringField
      FieldName = 'WebSite'
      Origin = 'WebSite'
      Size = 256
    end
    object tblSwimClubHeatAlgorithm: TIntegerField
      FieldName = 'HeatAlgorithm'
    end
    object tblSwimClubEnableTeamEvents: TBooleanField
      FieldName = 'EnableTeamEvents'
    end
    object tblSwimClubEnableSwimOThon: TBooleanField
      FieldName = 'EnableSwimOThon'
    end
    object tblSwimClubEnableExtHeatTypes: TBooleanField
      FieldName = 'EnableExtHeatTypes'
    end
    object tblSwimClubNumOfLanes: TIntegerField
      FieldName = 'NumOfLanes'
    end
    object tblSwimClubEnableMembershipStr: TBooleanField
      FieldName = 'EnableMembershipStr'
    end
    object tblSwimClubLenOfPool: TIntegerField
      FieldName = 'LenOfPool'
    end
  end
  object dsSwimClub: TDataSource
    DataSet = tblSwimClub
    Left = 112
    Top = 120
  end
  object dsSession: TDataSource
    DataSet = qrySession
    Left = 112
    Top = 264
  end
  object dsEvent: TDataSource
    DataSet = qryEvent
    Left = 104
    Top = 336
  end
  object dsMember: TDataSource
    DataSet = qryMember
    Left = 104
    Top = 184
  end
  object qrySession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Filter = 'SessionStatusID = 1'
    IndexFieldNames = 'SwimClubID'
    MasterSource = dsSwimClub
    MasterFields = 'SwimClubID'
    DetailFields = 'SwimClubID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime]
    FormatOptions.FmtDisplayDateTime = 'dddd dd/mm/yyyy HH:nn'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Session'
    UpdateOptions.KeyFields = 'SessionID'
    SQL.Strings = (
      ''
      'SELECT Session.SessionID'
      '    , Session.SessionStart'
      '    , Session.SwimClubID'
      '    , Session.SessionStatusID'
      '    , CASE '
      '        WHEN Session.SessionStatusID = 1'
      '            THEN '#39'(UNLOCKED)'#39
      '        ELSE '#39'(LOCKED)'#39
      '        END AS SessionStatusStr'
      '    , Session.Caption'
      
        '    , Format(SessionStart, '#39'dddd dd/MM/yyyy HH:mm'#39') AS SessionSt' +
        'artStr'
      '    , '
      '    CASE '
      '       WHEN SessionStatusID = 1'
      '       THEN'
      
        '       CONCAT( Format(SessionStart, '#39'yyyy-MM-dd HH:mm '#39'), Sessio' +
        'n.Caption)'
      '       ELSE'
      
        '       CONCAT( Format(SessionStart, '#39'yyyy-MM-dd'#39') , '#39'  (LOCKED) ' +
        #39')'
      '       END AS SessionDetailStr'
      '    '
      ''
      'FROM Session'
      ''
      'ORDER BY Session.SessionStart DESC'
      ''
      '')
    Left = 48
    Top = 264
    object qrySessionSessionID: TFDAutoIncField
      FieldName = 'SessionID'
      Origin = 'SessionID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qrySessionSessionStart: TSQLTimeStampField
      FieldName = 'SessionStart'
      Origin = 'SessionStart'
      DisplayFormat = 'dddd dd/mm/yyyy HH:nn'
    end
    object qrySessionSwimClubID: TIntegerField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
    end
    object qrySessionSessionStatusID: TIntegerField
      FieldName = 'SessionStatusID'
      Origin = 'SessionStatusID'
    end
    object qrySessionSessionStatusStr: TStringField
      FieldName = 'SessionStatusStr'
      Origin = 'SessionStatusStr'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object qrySessionCaption: TWideStringField
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object qrySessionSessionStartStr: TWideStringField
      FieldName = 'SessionStartStr'
      Origin = 'SessionStartStr'
      ReadOnly = True
      Size = 4000
    end
    object qrySessionSessionDetailStr: TWideStringField
      FieldName = 'SessionDetailStr'
      Origin = 'SessionDetailStr'
      ReadOnly = True
      Required = True
      Size = 4000
    end
  end
  object qryEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    MasterSource = dsSession
    MasterFields = 'SessionID'
    DetailFields = 'SessionID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'SELECT Event.EventID'
      '    , Event.EventNum'
      '    , qryNominees.NomineeCount'
      '    , qryEntrants.EntrantCount'
      '    , Event.SessionID'
      '    , Event.StrokeID'
      '    , Event.DistanceID'
      '    , Event.EventStatusID'
      '    , CONCAT ('
      '        '#39'#'#39
      '        , Format([EventNum], '#39'0#'#39')'
      '        , '#39' - '#39
      '        , Distance.Caption'
      '        , '#39' '#39
      '        , Stroke.Caption'
      '        ) AS Title'
      '    , CONCAT ('#39'- '#39', Event.Caption) AS Detail'
      ''
      'FROM Event'
      'LEFT OUTER JOIN Stroke'
      '    ON Stroke.StrokeID = Event.StrokeID'
      'LEFT OUTER JOIN Distance'
      '    ON Distance.DistanceID = Event.DistanceID'
      'LEFT OUTER JOIN EventStatus'
      '    ON EventStatus.EventStatusID = Event.EventStatusID'
      'LEFT JOIN ('
      '    SELECT Count(Nominee.EventID) AS NomineeCount'
      '        , EventID'
      '    FROM Nominee'
      '    GROUP BY Nominee.EventID'
      '    ) qryNominees'
      '    ON qryNominees.EventID = Event.EventID'
      'LEFT JOIN ('
      '    SELECT Count(Entrant.EntrantID) AS EntrantCount'
      '        , HeatIndividual.EventID'
      '    FROM Entrant'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    WHERE (Entrant.MemberID IS NOT NULL)'
      '    GROUP BY HeatIndividual.EventID'
      '    ) qryEntrants'
      '    ON qryEntrants.EventID = Event.EventID'
      'ORDER BY Event.EventNum;')
    Left = 40
    Top = 336
    object qryEventEventID: TFDAutoIncField
      FieldName = 'EventID'
      Origin = 'EventID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryEventEventNum: TIntegerField
      FieldName = 'EventNum'
      Origin = 'EventNum'
    end
    object qryEventNomineeCount: TIntegerField
      FieldName = 'NomineeCount'
      Origin = 'NomineeCount'
      ReadOnly = True
    end
    object qryEventEntrantCount: TIntegerField
      FieldName = 'EntrantCount'
      Origin = 'EntrantCount'
      ReadOnly = True
    end
    object qryEventSessionID: TIntegerField
      FieldName = 'SessionID'
      Origin = 'SessionID'
    end
    object qryEventStrokeID: TIntegerField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
    end
    object qryEventDistanceID: TIntegerField
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
    end
    object qryEventEventStatusID: TIntegerField
      FieldName = 'EventStatusID'
      Origin = 'EventStatusID'
    end
    object qryEventTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'Title'
      ReadOnly = True
      Required = True
      Size = 4000
    end
    object qryEventDetail: TWideStringField
      FieldName = 'Detail'
      Origin = 'Detail'
      ReadOnly = True
      Required = True
      Size = 130
    end
  end
  object qryMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimCLubMeet;'
      'DECLARE @MemberID INTEGER;'
      'SET @MemberID = :MEMBERID;'
      ''
      'SELECT '
      '[MemberID]'
      '      ,[MembershipNum]'
      '      ,[MembershipStr]'
      '      ,[FirstName]'
      '      ,[LastName]'
      '      ,[DOB]'
      '      ,[IsArchived]'
      '      ,[IsActive]'
      '      ,[IsSwimmer]'
      '      ,[Email]'
      '      ,[EnableEmailOut]'
      '      ,[GenderID]'
      '      ,[SwimClubID]'
      
        ',SubString(Concat(Member.FirstName, '#39' '#39', Upper(Member.LastName))' +
        ', 0, 60) AS FName'
      'FROM Member '
      'WHERE MemberID = @MemberID'
      'ORDER BY [LastName];')
    Left = 48
    Top = 184
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryMemberMemberID: TFDAutoIncField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryMemberMembershipNum: TIntegerField
      FieldName = 'MembershipNum'
      Origin = 'MembershipNum'
    end
    object qryMemberMembershipStr: TWideStringField
      FieldName = 'MembershipStr'
      Origin = 'MembershipStr'
      Size = 24
    end
    object qryMemberFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Size = 128
    end
    object qryMemberLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'LastName'
      Size = 128
    end
    object qryMemberDOB: TSQLTimeStampField
      FieldName = 'DOB'
      Origin = 'DOB'
    end
    object qryMemberIsArchived: TBooleanField
      FieldName = 'IsArchived'
      Origin = 'IsArchived'
      Required = True
    end
    object qryMemberIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
      Required = True
    end
    object qryMemberIsSwimmer: TBooleanField
      FieldName = 'IsSwimmer'
      Origin = 'IsSwimmer'
      Required = True
    end
    object qryMemberEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'Email'
      Size = 256
    end
    object qryMemberEnableEmailOut: TBooleanField
      FieldName = 'EnableEmailOut'
      Origin = 'EnableEmailOut'
      Required = True
    end
    object qryMemberGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
    end
    object qryMemberSwimClubID: TIntegerField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
    end
    object qryMemberFName: TWideStringField
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Size = 60
    end
  end
  object qryIsQualified_ORG: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INT;-- required (NULL returns no records)'
      
        'DECLARE @SessionStart AS DATETIME;-- required (sets cut-off rang' +
        'e, ie. PersonalBest '#39'as of'#39' up to and including the is date.)'
      
        'DECLARE @DistanceID AS INT;-- required (the Qualifying distance ' +
        'to check for qualification)'
      'DECLARE @StrokeID AS INT;-- required (the swimming stroke)'
      ''
      'DECLARE @MemberID AS INT;'
      ''
      '-- CALCULATED VARIABLES'
      
        'DECLARE @IsShortCourse AS BIT;-- calculated (important - uses Sw' +
        'imClubID)'
      
        'DECLARE @GenderID AS INT;-- calculated (important - qualificatio' +
        'n table splits MALE and FEMALE)'
      ''
      'SET @SessionStart = :SESSIONSTART'
      'SET @SwimClubID = :SWIMCLUBID;'
      'SET @MemberID = :MEMBERID;'
      ''
      'IF @SessionStart IS NULL'
      #9'SET @SessionStart = GetDate();'
      ''
      'SET @DistanceID = :DISTANCEID;'
      'SET @StrokeID = :STROKEID;'
      ''
      ''
      '-- as yet - not implemented in current release'
      '--SET @IsShortCourse = db0.IsPoolShortCourse(@SwimClubID);'
      ''
      '-- any thing under 50 meters is a shortcourse'
      'SET @IsShortCourse = ('
      #9#9'SELECT CASE '
      #9#9#9#9'WHEN [SwimClub].[LenOfPool] >= 50'
      #9#9#9#9#9'THEN 0'
      #9#9#9#9'ELSE 1'
      #9#9#9#9'END'
      #9#9'FROM SwimClub'
      #9#9'WHERE SwimClubID = @SwimClubID'
      #9#9');'
      ''
      '-- DROP TABLE IF EXISTS'
      'IF OBJECT_ID('#39'tempdb..#tblMember'#39', '#39'U'#39') IS NOT NULL'
      #9'DROP TABLE #tblMember;'
      ''
      '-- Member data and stroke ... distance'
      '-- tempory table to join member, PB and stroke/distance'
      'SELECT @DistanceID AS DistanceID'
      #9',@StrokeID AS StrokeID'
      #9',MemberID'
      #9',GenderID'
      #9',dbo.PersonalBest(MemberID, ('
      #9#9#9'SELECT TrialDistID'
      #9#9#9'FROM Qualify'
      #9#9#9'WHERE (Qualify.StrokeID = @StrokeID)'
      #9#9#9#9'AND (Qualify.QualifyDistID = @DistanceID)'
      #9#9#9#9'AND (Qualify.IsShortCourse = @IsShortCourse)'
      #9#9#9#9'AND (Qualify.GenderID = Member.GenderID)'
      #9#9#9'), @StrokeID, @SessionStart) AS TrialTimePB'
      #9',IsActive'
      'INTO #tblMember'
      'FROM Member'
      ''
      ''
      ''
      ''
      '-- OUTPUTS MemberID and treu/false if qualified'
      'SELECT #tblMember.[MemberID]'
      #9'--'#9',#tblMember.TrialTimePB'
      #9'--'#9',TrialTime'
      
        #9'--,IIF(#tblMember.TrialTimePB <= TrialTime, 1, 0) AS IsQualifie' +
        'd'
      'FROM [dbo].Qualify'
      
        'INNER JOIN #tblMember ON Qualify.QualifyDistID = #tblMember.Dist' +
        'anceID'
      #9'AND Qualify.StrokeID = #tblMember.StrokeID'
      'WHERE #tblMember.[IsActive] = 1'
      '        AND #tblMember.MemberID = @MemberID'
      #9'AND [dbo].Qualify.IsShortCourse = @IsShortCourse'
      #9'AND Qualify.StrokeID = @StrokeID'
      #9'AND Qualify.GenderID = #tblMember.GenderID'
      'AND IIF(#tblMember.TrialTimePB <= TrialTime, 1, 0) = 1')
    Left = 296
    Top = 176
    ParamData = <
      item
        Name = 'SESSIONSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 6
      end
      item
        Name = 'DISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryIsQualified: TFDQuery
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      ''
      'DECLARE @MemberID INTEGER;'
      'DECLARE @DistanceID INTEGER;'
      'DECLARE @StrokeID INTEGER;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @DistanceID = :DISTANCEID;'
      'SET @StrokeID = :STROKEID;'
      ''
      
        'SELECT dbo.IsMemberQualified(@MemberID, null, @DistanceID, @Stro' +
        'keID) AS QUALIFIED;')
    Left = 296
    Top = 32
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryIsNominated: TFDQuery
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @MemberID INTEGER;'
      'DECLARE @EventID INTEGER;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @EventID = :EVENTID;'
      ''
      
        'SELECT NomineeID FROM Nominee WHERE MemberID = @MemberID AND Eve' +
        'ntID = @EventID;')
    Left = 296
    Top = 104
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object cmdDeleteSplit: TFDCommand
    Connection = scmConnection
    CommandText.Strings = (
      'USE SwimClubMeet;'
      ''
      'SET ANSI_NULLS ON;'
      'SET QUOTED_IDENTIFIER ON;'
      'SET NOCOUNT ON;'
      ''
      'DECLARE @EntrantID INTEGER;'
      'SET @EntrantID = :ENTRANTID;'
      ''
      'DELETE FROM dbo.Split WHERE dbo.Split.EntrantID = @EntrantID;')
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 296
    Top = 328
  end
  object cmdDeleteEntrant: TFDCommand
    Connection = scmConnection
    CommandText.Strings = (
      'USE SwimClubMeet;'
      ''
      'SET ANSI_NULLS ON;'
      'SET QUOTED_IDENTIFIER ON;'
      'SET NOCOUNT ON;'
      ''
      'DECLARE @EntrantID INTEGER;'
      'SET @EntrantID = :ENTRANTID;'
      ''
      
        'DELETE FROM dbo.Entrant WHERE dbo.Entrant.EntrantID = @EntrantID' +
        ';')
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 296
    Top = 384
  end
  object cmdCreateNomination: TFDCommand
    Connection = scmConnection
    CommandText.Strings = (
      'USE [SwimClubMeet];'
      ''
      'SET ANSI_NULLS ON;'
      'SET QUOTED_IDENTIFIER ON;'
      'SET NOCOUNT ON;'
      ''
      'DECLARE @MemberID INTEGER;'
      'DECLARE @EventID INTEGER;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @EventID = :EVENTID;'
      ''
      'IF @MemberID IS NULL RETURN;'
      'IF @EventID IS NULL RETURN;'
      ''
      '-- TODO: Assume AutoBuild fully populates params?'
      ''
      'INSERT INTO [dbo].[Nominee]'
      '           ([TTB]'
      '           ,[PB]'
      '           ,[SeedTime]'
      '           ,[AutoBuildFlag]'
      '           ,[EventID]'
      '           ,[MemberID])'
      '     VALUES'
      '           ('
      '           NULL'
      '           ,NULL'
      '           ,NULL'
      '           ,0'
      '           ,@EventID'
      '           ,@MemberID'
      '           );'
      ''
      '')
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 296
    Top = 256
  end
  object cmdDeleteNomination: TFDCommand
    Connection = scmConnection
    CommandText.Strings = (
      'USE SwimClubMeet;'
      ''
      'SET ANSI_NULLS ON;'
      'SET QUOTED_IDENTIFIER ON;'
      'SET NOCOUNT ON;'
      ''
      'DECLARE @MemberID INTEGER;'
      'DECLARE @EventID INTEGER;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @EventID = :EVENTID;'
      ''
      
        'DELETE FROM dbo.Nominee WHERE dbo.Nominee.MemberID = @MemberID A' +
        'ND dbo.Nominee.EventID = @EventID;')
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 296
    Top = 440
  end
  object qryIsEntrant: TFDQuery
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SET ANSI_NULLS ON;'
      'SET QUOTED_IDENTIFIER ON;'
      'SET NOCOUNT ON;'
      ''
      'DECLARE @MemberID INTEGER;'
      'DECLARE @EventID INTEGER;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @EventID = :EVENTID;'
      ''
      'SELECT EntrantID FROM  dbo.HeatIndividual '
      
        'INNER JOIN dbo.Entrant ON dbo.HeatIndividual.HeatID = Entrant.He' +
        'atID '
      
        'WHERE dbo.Entrant.MemberID = @MemberID AND dbo.HeatIndividual.Ev' +
        'entID = @EventID;')
    Left = 296
    Top = 504
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrySCMSystem: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT * FROM SCMSystem WHERE SCMSystemID = 1;')
    Left = 472
    Top = 192
  end
  object dsSCMSystem: TDataSource
    DataSet = qrySCMSystem
    Left = 560
    Top = 192
  end
  object qrySessionNominations: TFDQuery
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @MemberID INTEGER;'
      'DECLARE @SessionID INTEGER;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @SessionID = :SESSIONID;'
      ''
      
        'SELECT Event.SessionID, Nominee.NomineeID, Nominee.EventID, Nomi' +
        'nee.MemberID FROM Nominee'
      'INNER JOIN Event ON Nominee.EventID = Event.EventID'
      
        'WHERE Event.SessionID = @SessionID AND Nominee.MemberID = @Membe' +
        'rID'
      'ORDER BY Nominee.EventID;')
    Left = 496
    Top = 104
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 120
      end>
  end
end
