gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
gui_open_cov  -hier simv.vdb -testdir  {simv.vdb} -test { simv/test } -merge MergedTest -db_max_tests 10 -fsm transition
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} {/$unit::apb_monitor::apb_pkt_cg}
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::apb_monitor::apb_pkt_cg.c22}   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} {$unit::apb_monitor::apb_pkt_cg.c22}  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::apb_monitor::apb_pkt_cg.c22}  {$unit::apb_monitor::apb_pkt_cg.c12}   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} {$unit::apb_monitor::apb_pkt_cg.c12}  -column {Group} 
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
vdCovExit -noprompt
