\c tap_schema;

CREATE TABLE ivoa.obscore
(
   obs_publisher_did varchar(256) NOT NULL,
   obs_id varchar(128),
   obs_collection char(32),
   proposal_id varchar(128),
   dataproduct_type varchar(5),
   dataproduct_subtype varchar(5),
   calib_level char(20),
   access_url varchar(256),
   access_format varchar(16),
   access_estsize decimal(20,0),
   target_name varchar(256),
   s_ra DOUBLE PRECISION,
   s_dec DOUBLE PRECISION,
   s_fov DOUBLE PRECISION,
   s_region spoly,
   s_resolution DOUBLE PRECISION,
   s_xel1 DOUBLE PRECISION,
   s_xel2 DOUBLE PRECISION,
   t_min DOUBLE PRECISION,
   t_max DOUBLE PRECISION,
   t_exptime decimal(10,3),
   t_resolution decimal(10,3),
   t_xel DOUBLE PRECISION,
   em_min DOUBLE PRECISION,
   em_max DOUBLE PRECISION,
   em_res_power DOUBLE PRECISION,
   em_xel DOUBLE PRECISION,
   o_ucd char(35),
   pol_states varchar(64),
   pol_xel DOUBLE PRECISION,
   facility_name char(32),
   instrument_name char(32)
);

INSERT INTO tap_schema.schemas11 (schema_name, description, utype, schema_index)
  VALUES ('ivoa', 'IVOA ObsCore schema', NULL, 100);

INSERT INTO tap_schema.tables11 (schema_name, table_name, table_type, description, utype, table_index)
  VALUES ('ivoa', 'ivoa.obscore', 'table', '(experimental) basic ObsCore table', NULL, 105000);

INSERT
  INTO tap_schema.columns11 (table_name,column_name,utype,ucd,unit,description,datatype,arraysize,xtype,principal,indexed,std,column_index,id)
  VALUES
  ('ivoa.obscore','calib_level','obscore:ObsDataset.calibLevel','meta.code;obs.calib',null,'calibration level (0,1,2,3)','int',null,null,1,0,1,5,null),
  ('ivoa.obscore','s_ra','obscore:Char.SpatialAxis.Coverage.Location.Coord.Position2D.Value2.C1','pos.eq.ra','deg','RA of central coordinates','double',null,null,1,0,1,9,null),
  ('ivoa.obscore','s_dec','obscore:Char.SpatialAxis.Coverage.Location.Coord.Position2D.Value2.C2','pos.eq.dec','deg','DEC of central coordinates','double',null,null,1,0,1,10,null),
  ('ivoa.obscore','s_fov','obscore:Char.SpatialAxis.Coverage.Bounds.Extent.diameter','phys.angSize;instr.fov','deg','size of the region covered (~diameter of minimum bounding circle)','double',null,null,1,0,1,11,null),
  ('ivoa.obscore','s_region','obscore:Char.SpatialAxis.Coverage.Support.Area','phys.outline;obs.field','deg','region bounded by observation','char','*','adql:REGION',1,1,1,12,null),
  ('ivoa.obscore','s_resolution','obscore:Char.SpatialAxis.Resolution.refval.value','pos.angResolution','arcsec','typical spatial resolution','double',null,null,1,0,1,13,null),
  ('ivoa.obscore','s_xel1','obscore:Char.SpatialAxis.numBins1','meta.number',null,'','double',null,null,1,0,1,28,null),
  ('ivoa.obscore','s_xel2','obscore:Char.SpatialAxis.numBins2','meta.number',null,'','double',null,null,1,0,1,29,null),
  ('ivoa.obscore','t_min','obscore:Char.TimeAxis.Coverage.Bounds.Limits.StartTime','time.start;obs.exposure','d','start time of observation (MJD)','double',null,null,1,1,1,14,null),
  ('ivoa.obscore','t_max','obscore:Char.TimeAxis.Coverage.Bounds.Limits.StopTime','time.end;obs.exposure','d','end time of observation (MJD)','double',null,null,1,1,1,15,null),
  ('ivoa.obscore','t_exptime','obscore:Char.TimeAxis.Coverage.Support.Extent','time.duration;obs.exposure','s','exposure time of observation','double',null,null,1,1,1,16,null),
  ('ivoa.obscore','t_resolution','obscore:Char.TimeAxis.Resolution.refval.value','time.resolution','s','typical temporal resolution','double',null,null,1,0,1,17,null),
  ('ivoa.obscore','t_xel','obscore:Char.TimeAxis.numBins','meta.number',null,'number of time axis bins','double',null,null,1,1,1,28,null),
  ('ivoa.obscore','em_min','obscore:Char.SpectralAxis.Coverage.Bounds.Limits.LoLimit','em.wl;stat.min','m','start spectral coordinate value','double',null,null,1,1,1,18,null),
  ('ivoa.obscore','em_max','obscore:Char.SpectralAxis.Coverage.Bounds.Limits.HiLimit','em.wl;stat.max','m','stop spectral coordinate value','double',null,null,1,1,1,19,null),
  ('ivoa.obscore','em_res_power','obscore:Char.SpectralAxis.Resolution.ResolPower.refval','spect.resolution',null,'typical spectral resolution','double',null,null,1,0,1,20,null),
  ('ivoa.obscore','em_xel','obscore:Char.SpectralAxis.numBins','meta.number',null,'number of spectral axis bins','double',null,null,1,1,1,27,null),
  ('ivoa.obscore','access_url','obscore:Access.Reference','meta.ref.url',null,'URL to download the data','char','*','clob',1,0,1,6,null),
  ('ivoa.obscore','access_format','obscore:Access.Format','meta.code.mime',null,'Content format of the data','char','128*',null,1,0,1,31,null),
  ('ivoa.obscore','access_estsize','obscore:Access.Size','phys.size;meta.file','kbyte','estimated size of the download','long',null,null,1,0,1,7,null),
  ('ivoa.obscore','obs_publisher_did','obscore:Curation.PublisherDID','meta.ref.url;meta.curation',null,'publisher dataset identifier','char','256*',null,1,1,1,1,null),
  ('ivoa.obscore','obs_collection','obscore:DataID.Collection','meta.id',null,'short name for the data colection','char','128*',null,1,0,1,3,null),
  ('ivoa.obscore','facility_name','obscore:Provenance.ObsConfig.Facility.name','meta.id;instr.tel',null,'telescope name','char','128*',null,1,0,1,23,null),
  ('ivoa.obscore','instrument_name','obscore:Provenance.ObsConfig.Instrument.name','meta.id;instr',null,'instrument name','char','128*',null,1,0,1,24,null),
  ('ivoa.obscore','obs_id','obscore:DataID.observationID','meta.id',null,'internal dataset identifier','char','128*',null,1,0,1,2,null),
  ('ivoa.obscore','proposal_id','obscore:Provenance.Proposal.identifier','meta.id;obs.proposal',null,'proposal id','char','128*',null,1,0,1,25,null),
  ('ivoa.obscore','dataproduct_type','obscore:ObsDataset.dataProductType','meta.id',null,'type of product','char','128*',null,1,0,1,4,null),
  ('ivoa.obscore','dataproduct_subtype','obscore:ObsDataset.dataProductSubtype','meta.id',null,'subtype of product','char','128*',null,1,0,1,26,null),
  ('ivoa.obscore','target_name','obscore:Target.Name','meta.id;src',null,'name of intended target','char','32*',null,1,0,1,8,null),
  ('ivoa.obscore','pol_states','obscore:Char.PolarizationAxis.stateList','meta.code;phys.polarization',null,'polarization states present in the data','char','32*',null,1,0,1,22,null),
  ('ivoa.obscore','pol_xel','obscore:Char.PolarizationAxis.numBins','meta.number',null,'','double',null,null,1,0,1,30,null),
  ('ivoa.obscore','o_ucd','obscore:Char.ObservableAxis.ucd','meta.ucd',null,'UCD describing the observable axis (pixel values)','char','32*',null,1,0,1,21,null);
