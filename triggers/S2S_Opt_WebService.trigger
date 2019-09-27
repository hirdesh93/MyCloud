trigger S2S_Opt_WebService on Opportunity (after insert) {
    con_Opt_Invoke_Class.Con_Opt_Invoke_Ins_Mtd(Trigger.new[0].id);
}