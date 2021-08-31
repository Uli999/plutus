(program
  (let
    (nonrec)
    (datatypebind
      (datatype
        (tyvardecl CampaignAction (type))

        CampaignAction_match
        (vardecl Collect CampaignAction) (vardecl Refund CampaignAction)
      )
    )
    (datatypebind
      (datatype
        (tyvardecl Credential (type))

        Credential_match
        (vardecl PubKeyCredential (fun (con bytestring) Credential))
        (vardecl ScriptCredential (fun (con bytestring) Credential))
      )
    )
    (datatypebind
      (datatype
        (tyvardecl StakingCredential (type))

        StakingCredential_match
        (vardecl StakingHash (fun Credential StakingCredential))
        (vardecl
          StakingPtr
          (fun
            (con integer)
            (fun (con integer) (fun (con integer) StakingCredential))
          )
        )
      )
    )
    (datatypebind
      (datatype
        (tyvardecl DCert (type))

        DCert_match
        (vardecl DCertDelegDeRegKey (fun StakingCredential DCert))
        (vardecl
          DCertDelegDelegate
          (fun StakingCredential (fun (con bytestring) DCert))
        )
        (vardecl DCertDelegRegKey (fun StakingCredential DCert))
        (vardecl DCertGenesis DCert)
        (vardecl DCertMir DCert)
        (vardecl
          DCertPoolRegister (fun (con bytestring) (fun (con bytestring) DCert))
        )
        (vardecl
          DCertPoolRetire (fun (con bytestring) (fun (con integer) DCert))
        )
      )
    )
    (datatypebind
      (datatype
        (tyvardecl TxOutRef (type))

        TxOutRef_match
        (vardecl TxOutRef (fun (con bytestring) (fun (con integer) TxOutRef)))
      )
    )
    (datatypebind
      (datatype
        (tyvardecl ScriptPurpose (type))

        ScriptPurpose_match
        (vardecl Certifying (fun DCert ScriptPurpose))
        (vardecl Minting (fun (con bytestring) ScriptPurpose))
        (vardecl Rewarding (fun StakingCredential ScriptPurpose))
        (vardecl Spending (fun TxOutRef ScriptPurpose))
      )
    )
    (datatypebind
      (datatype
        (tyvardecl Bool (type))

        Bool_match
        (vardecl True Bool) (vardecl False Bool)
      )
    )
    (datatypebind
      (datatype
        (tyvardecl Extended (fun (type) (type)))
        (tyvardecl a (type))
        Extended_match
        (vardecl Finite (fun a [ Extended a ]))
        (vardecl NegInf [ Extended a ])
        (vardecl PosInf [ Extended a ])
      )
    )
    (datatypebind
      (datatype
        (tyvardecl LowerBound (fun (type) (type)))
        (tyvardecl a (type))
        LowerBound_match
        (vardecl LowerBound (fun [ Extended a ] (fun Bool [ LowerBound a ])))
      )
    )
    (datatypebind
      (datatype
        (tyvardecl UpperBound (fun (type) (type)))
        (tyvardecl a (type))
        UpperBound_match
        (vardecl UpperBound (fun [ Extended a ] (fun Bool [ UpperBound a ])))
      )
    )
    (datatypebind
      (datatype
        (tyvardecl Interval (fun (type) (type)))
        (tyvardecl a (type))
        Interval_match
        (vardecl
          Interval (fun [ LowerBound a ] (fun [ UpperBound a ] [ Interval a ]))
        )
      )
    )
    (datatypebind
      (datatype
        (tyvardecl Maybe (fun (type) (type)))
        (tyvardecl a (type))
        Maybe_match
        (vardecl Just (fun a [ Maybe a ])) (vardecl Nothing [ Maybe a ])
      )
    )
    (datatypebind
      (datatype
        (tyvardecl Address (type))

        Address_match
        (vardecl
          Address (fun Credential (fun [ Maybe StakingCredential ] Address))
        )
      )
    )
    (datatypebind
      (datatype
        (tyvardecl Tuple2 (fun (type) (fun (type) (type))))
        (tyvardecl a (type)) (tyvardecl b (type))
        Tuple2_match
        (vardecl Tuple2 (fun a (fun b [ [ Tuple2 a ] b ])))
      )
    )
    (let
      (rec)
      (datatypebind
        (datatype
          (tyvardecl List (fun (type) (type)))
          (tyvardecl a (type))
          Nil_match
          (vardecl Nil [ List a ])
          (vardecl Cons (fun a (fun [ List a ] [ List a ])))
        )
      )
      (let
        (nonrec)
        (datatypebind
          (datatype
            (tyvardecl TxOut (type))

            TxOut_match
            (vardecl
              TxOut
              (fun
                Address
                (fun
                  [
                    [
                      (lam k (type) (lam v (type) [ List [ [ Tuple2 k ] v ] ]))
                      (con bytestring)
                    ]
                    [
                      [
                        (lam
                          k (type) (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                        )
                        (con bytestring)
                      ]
                      (con integer)
                    ]
                  ]
                  (fun [ Maybe (con bytestring) ] TxOut)
                )
              )
            )
          )
        )
        (datatypebind
          (datatype
            (tyvardecl TxInInfo (type))

            TxInInfo_match
            (vardecl TxInInfo (fun TxOutRef (fun TxOut TxInInfo)))
          )
        )
        (datatypebind
          (datatype
            (tyvardecl TxInfo (type))

            TxInfo_match
            (vardecl
              TxInfo
              (fun
                [ List TxInInfo ]
                (fun
                  [ List TxOut ]
                  (fun
                    [
                      [
                        (lam
                          k (type) (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                        )
                        (con bytestring)
                      ]
                      [
                        [
                          (lam
                            k (type) (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                          )
                          (con bytestring)
                        ]
                        (con integer)
                      ]
                    ]
                    (fun
                      [
                        [
                          (lam
                            k (type) (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                          )
                          (con bytestring)
                        ]
                        [
                          [
                            (lam
                              k
                              (type)
                              (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                            )
                            (con bytestring)
                          ]
                          (con integer)
                        ]
                      ]
                      (fun
                        [ List DCert ]
                        (fun
                          [
                            List [ [ Tuple2 StakingCredential ] (con integer) ]
                          ]
                          (fun
                            [ Interval (con integer) ]
                            (fun
                              [ List (con bytestring) ]
                              (fun
                                [
                                  List
                                  [ [ Tuple2 (con bytestring) ] (con data) ]
                                ]
                                (fun (con bytestring) TxInfo)
                              )
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
        (datatypebind
          (datatype
            (tyvardecl ScriptContext (type))

            ScriptContext_match
            (vardecl
              ScriptContext (fun TxInfo (fun ScriptPurpose ScriptContext))
            )
          )
        )
        (datatypebind
          (datatype
            (tyvardecl UTuple2 (fun (type) (fun (type) (type))))
            (tyvardecl a (type)) (tyvardecl b (type))
            UTuple2_match
            (vardecl UTuple2 (fun a (fun b [ [ UTuple2 a ] b ])))
          )
        )
        (datatypebind
          (datatype
            (tyvardecl Campaign (type))

            Campaign_match
            (vardecl
              Campaign
              (fun
                (con integer)
                (fun (con integer) (fun (con bytestring) Campaign))
              )
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            wcollectionRange
            (fun
              Campaign
              [
                [ UTuple2 [ LowerBound (con integer) ] ]
                [ UpperBound (con integer) ]
              ]
            )
          )
          (lam
            w
            Campaign
            [
              [
                {
                  { UTuple2 [ LowerBound (con integer) ] }
                  [ UpperBound (con integer) ]
                }
                [
                  [
                    { LowerBound (con integer) }
                    [
                      { Finite (con integer) }
                      [
                        { [ Campaign_match w ] (con integer) }
                        (lam
                          ds
                          (con integer)
                          (lam ds (con integer) (lam ds (con bytestring) ds))
                        )
                      ]
                    ]
                  ]
                  True
                ]
              ]
              [
                [
                  { UpperBound (con integer) }
                  [
                    { Finite (con integer) }
                    [
                      [
                        (builtin subtractInteger)
                        [
                          { [ Campaign_match w ] (con integer) }
                          (lam
                            ds
                            (con integer)
                            (lam ds (con integer) (lam ds (con bytestring) ds))
                          )
                        ]
                      ]
                      (con integer 1)
                    ]
                  ]
                ]
                True
              ]
            ]
          )
        )
        (datatypebind
          (datatype
            (tyvardecl Ordering (type))

            Ordering_match
            (vardecl EQ Ordering) (vardecl GT Ordering) (vardecl LT Ordering)
          )
        )
        (datatypebind
          (datatype
            (tyvardecl Ord (fun (type) (type)))
            (tyvardecl a (type))
            Ord_match
            (vardecl
              CConsOrd
              (fun
                [ (lam a (type) (fun a (fun a Bool))) a ]
                (fun
                  (fun a (fun a Ordering))
                  (fun
                    (fun a (fun a Bool))
                    (fun
                      (fun a (fun a Bool))
                      (fun
                        (fun a (fun a Bool))
                        (fun
                          (fun a (fun a Bool))
                          (fun
                            (fun a (fun a a)) (fun (fun a (fun a a)) [ Ord a ])
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            compare (all a (type) (fun [ Ord a ] (fun a (fun a Ordering))))
          )
          (abs
            a
            (type)
            (lam
              v
              [ Ord a ]
              [
                { [ { Ord_match a } v ] (fun a (fun a Ordering)) }
                (lam
                  v
                  [ (lam a (type) (fun a (fun a Bool))) a ]
                  (lam
                    v
                    (fun a (fun a Ordering))
                    (lam
                      v
                      (fun a (fun a Bool))
                      (lam
                        v
                        (fun a (fun a Bool))
                        (lam
                          v
                          (fun a (fun a Bool))
                          (lam
                            v
                            (fun a (fun a Bool))
                            (lam
                              v (fun a (fun a a)) (lam v (fun a (fun a a)) v)
                            )
                          )
                        )
                      )
                    )
                  )
                )
              ]
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            hull_ccompare
            (all
              a
              (type)
              (fun [ Ord a ] (fun [ Extended a ] (fun [ Extended a ] Ordering)))
            )
          )
          (abs
            a
            (type)
            (lam
              dOrd
              [ Ord a ]
              (lam
                ds
                [ Extended a ]
                (lam
                  ds
                  [ Extended a ]
                  (let
                    (nonrec)
                    (termbind
                      (strict)
                      (vardecl fail (fun (all a (type) a) Ordering))
                      (lam ds (all a (type) a) (error Ordering))
                    )
                    {
                      [
                        [
                          [
                            {
                              [ { Extended_match a } ds ]
                              (all dead (type) Ordering)
                            }
                            (lam
                              default_arg0
                              a
                              (abs
                                dead
                                (type)
                                {
                                  [
                                    [
                                      [
                                        {
                                          [ { Extended_match a } ds ]
                                          (all dead (type) Ordering)
                                        }
                                        (lam
                                          default_arg0
                                          a
                                          (abs
                                            dead
                                            (type)
                                            (let
                                              (nonrec)
                                              (termbind
                                                (strict)
                                                (vardecl
                                                  fail
                                                  (fun
                                                    (all a (type) a) Ordering
                                                  )
                                                )
                                                (lam
                                                  ds
                                                  (all a (type) a)
                                                  {
                                                    [
                                                      [
                                                        [
                                                          {
                                                            [
                                                              {
                                                                Extended_match a
                                                              }
                                                              ds
                                                            ]
                                                            (all
                                                              dead
                                                              (type)
                                                              Ordering
                                                            )
                                                          }
                                                          (lam
                                                            default_arg0
                                                            a
                                                            (abs
                                                              dead
                                                              (type)
                                                              {
                                                                [
                                                                  [
                                                                    [
                                                                      {
                                                                        [
                                                                          {
                                                                            Extended_match
                                                                            a
                                                                          }
                                                                          ds
                                                                        ]
                                                                        (all
                                                                          dead
                                                                          (type)
                                                                          Ordering
                                                                        )
                                                                      }
                                                                      (lam
                                                                        l
                                                                        a
                                                                        (abs
                                                                          dead
                                                                          (type)
                                                                          {
                                                                            [
                                                                              [
                                                                                [
                                                                                  {
                                                                                    [
                                                                                      {
                                                                                        Extended_match
                                                                                        a
                                                                                      }
                                                                                      ds
                                                                                    ]
                                                                                    (all
                                                                                      dead
                                                                                      (type)
                                                                                      Ordering
                                                                                    )
                                                                                  }
                                                                                  (lam
                                                                                    r
                                                                                    a
                                                                                    (abs
                                                                                      dead
                                                                                      (type)
                                                                                      [
                                                                                        [
                                                                                          [
                                                                                            {
                                                                                              compare
                                                                                              a
                                                                                            }
                                                                                            dOrd
                                                                                          ]
                                                                                          l
                                                                                        ]
                                                                                        r
                                                                                      ]
                                                                                    )
                                                                                  )
                                                                                ]
                                                                                (abs
                                                                                  dead
                                                                                  (type)
                                                                                  [
                                                                                    fail
                                                                                    (abs
                                                                                      e
                                                                                      (type)
                                                                                      (error
                                                                                        e
                                                                                      )
                                                                                    )
                                                                                  ]
                                                                                )
                                                                              ]
                                                                              (abs
                                                                                dead
                                                                                (type)
                                                                                [
                                                                                  fail
                                                                                  (abs
                                                                                    e
                                                                                    (type)
                                                                                    (error
                                                                                      e
                                                                                    )
                                                                                  )
                                                                                ]
                                                                              )
                                                                            ]
                                                                            (all
                                                                              dead
                                                                              (type)
                                                                              dead
                                                                            )
                                                                          }
                                                                        )
                                                                      )
                                                                    ]
                                                                    (abs
                                                                      dead
                                                                      (type)
                                                                      [
                                                                        fail
                                                                        (abs
                                                                          e
                                                                          (type)
                                                                          (error
                                                                            e
                                                                          )
                                                                        )
                                                                      ]
                                                                    )
                                                                  ]
                                                                  (abs
                                                                    dead
                                                                    (type)
                                                                    GT
                                                                  )
                                                                ]
                                                                (all
                                                                  dead
                                                                  (type)
                                                                  dead
                                                                )
                                                              }
                                                            )
                                                          )
                                                        ]
                                                        (abs
                                                          dead
                                                          (type)
                                                          {
                                                            [
                                                              [
                                                                [
                                                                  {
                                                                    [
                                                                      {
                                                                        Extended_match
                                                                        a
                                                                      }
                                                                      ds
                                                                    ]
                                                                    (all
                                                                      dead
                                                                      (type)
                                                                      Ordering
                                                                    )
                                                                  }
                                                                  (lam
                                                                    l
                                                                    a
                                                                    (abs
                                                                      dead
                                                                      (type)
                                                                      {
                                                                        [
                                                                          [
                                                                            [
                                                                              {
                                                                                [
                                                                                  {
                                                                                    Extended_match
                                                                                    a
                                                                                  }
                                                                                  ds
                                                                                ]
                                                                                (all
                                                                                  dead
                                                                                  (type)
                                                                                  Ordering
                                                                                )
                                                                              }
                                                                              (lam
                                                                                r
                                                                                a
                                                                                (abs
                                                                                  dead
                                                                                  (type)
                                                                                  [
                                                                                    [
                                                                                      [
                                                                                        {
                                                                                          compare
                                                                                          a
                                                                                        }
                                                                                        dOrd
                                                                                      ]
                                                                                      l
                                                                                    ]
                                                                                    r
                                                                                  ]
                                                                                )
                                                                              )
                                                                            ]
                                                                            (abs
                                                                              dead
                                                                              (type)
                                                                              [
                                                                                fail
                                                                                (abs
                                                                                  e
                                                                                  (type)
                                                                                  (error
                                                                                    e
                                                                                  )
                                                                                )
                                                                              ]
                                                                            )
                                                                          ]
                                                                          (abs
                                                                            dead
                                                                            (type)
                                                                            [
                                                                              fail
                                                                              (abs
                                                                                e
                                                                                (type)
                                                                                (error
                                                                                  e
                                                                                )
                                                                              )
                                                                            ]
                                                                          )
                                                                        ]
                                                                        (all
                                                                          dead
                                                                          (type)
                                                                          dead
                                                                        )
                                                                      }
                                                                    )
                                                                  )
                                                                ]
                                                                (abs
                                                                  dead
                                                                  (type)
                                                                  [
                                                                    fail
                                                                    (abs
                                                                      e
                                                                      (type)
                                                                      (error e)
                                                                    )
                                                                  ]
                                                                )
                                                              ]
                                                              (abs
                                                                dead (type) GT
                                                              )
                                                            ]
                                                            (all
                                                              dead (type) dead
                                                            )
                                                          }
                                                        )
                                                      ]
                                                      (abs dead (type) LT)
                                                    ]
                                                    (all dead (type) dead)
                                                  }
                                                )
                                              )
                                              {
                                                [
                                                  [
                                                    [
                                                      {
                                                        [
                                                          { Extended_match a }
                                                          ds
                                                        ]
                                                        (all
                                                          dead (type) Ordering
                                                        )
                                                      }
                                                      (lam
                                                        default_arg0
                                                        a
                                                        (abs
                                                          dead
                                                          (type)
                                                          [
                                                            fail
                                                            (abs
                                                              e (type) (error e)
                                                            )
                                                          ]
                                                        )
                                                      )
                                                    ]
                                                    (abs
                                                      dead
                                                      (type)
                                                      [
                                                        fail
                                                        (abs e (type) (error e))
                                                      ]
                                                    )
                                                  ]
                                                  (abs
                                                    dead
                                                    (type)
                                                    {
                                                      [
                                                        [
                                                          [
                                                            {
                                                              [
                                                                {
                                                                  Extended_match
                                                                  a
                                                                }
                                                                ds
                                                              ]
                                                              (all
                                                                dead
                                                                (type)
                                                                Ordering
                                                              )
                                                            }
                                                            (lam
                                                              default_arg0
                                                              a
                                                              (abs
                                                                dead
                                                                (type)
                                                                [
                                                                  fail
                                                                  (abs
                                                                    e
                                                                    (type)
                                                                    (error e)
                                                                  )
                                                                ]
                                                              )
                                                            )
                                                          ]
                                                          (abs
                                                            dead
                                                            (type)
                                                            [
                                                              fail
                                                              (abs
                                                                e
                                                                (type)
                                                                (error e)
                                                              )
                                                            ]
                                                          )
                                                        ]
                                                        (abs dead (type) EQ)
                                                      ]
                                                      (all dead (type) dead)
                                                    }
                                                  )
                                                ]
                                                (all dead (type) dead)
                                              }
                                            )
                                          )
                                        )
                                      ]
                                      (abs dead (type) GT)
                                    ]
                                    (abs
                                      dead
                                      (type)
                                      (let
                                        (nonrec)
                                        (termbind
                                          (strict)
                                          (vardecl
                                            fail (fun (all a (type) a) Ordering)
                                          )
                                          (lam
                                            ds
                                            (all a (type) a)
                                            {
                                              [
                                                [
                                                  [
                                                    {
                                                      [
                                                        { Extended_match a } ds
                                                      ]
                                                      (all dead (type) Ordering)
                                                    }
                                                    (lam
                                                      default_arg0
                                                      a
                                                      (abs
                                                        dead
                                                        (type)
                                                        {
                                                          [
                                                            [
                                                              [
                                                                {
                                                                  [
                                                                    {
                                                                      Extended_match
                                                                      a
                                                                    }
                                                                    ds
                                                                  ]
                                                                  (all
                                                                    dead
                                                                    (type)
                                                                    Ordering
                                                                  )
                                                                }
                                                                (lam
                                                                  l
                                                                  a
                                                                  (abs
                                                                    dead
                                                                    (type)
                                                                    {
                                                                      [
                                                                        [
                                                                          [
                                                                            {
                                                                              [
                                                                                {
                                                                                  Extended_match
                                                                                  a
                                                                                }
                                                                                ds
                                                                              ]
                                                                              (all
                                                                                dead
                                                                                (type)
                                                                                Ordering
                                                                              )
                                                                            }
                                                                            (lam
                                                                              r
                                                                              a
                                                                              (abs
                                                                                dead
                                                                                (type)
                                                                                [
                                                                                  [
                                                                                    [
                                                                                      {
                                                                                        compare
                                                                                        a
                                                                                      }
                                                                                      dOrd
                                                                                    ]
                                                                                    l
                                                                                  ]
                                                                                  r
                                                                                ]
                                                                              )
                                                                            )
                                                                          ]
                                                                          (abs
                                                                            dead
                                                                            (type)
                                                                            [
                                                                              fail
                                                                              (abs
                                                                                e
                                                                                (type)
                                                                                (error
                                                                                  e
                                                                                )
                                                                              )
                                                                            ]
                                                                          )
                                                                        ]
                                                                        (abs
                                                                          dead
                                                                          (type)
                                                                          [
                                                                            fail
                                                                            (abs
                                                                              e
                                                                              (type)
                                                                              (error
                                                                                e
                                                                              )
                                                                            )
                                                                          ]
                                                                        )
                                                                      ]
                                                                      (all
                                                                        dead
                                                                        (type)
                                                                        dead
                                                                      )
                                                                    }
                                                                  )
                                                                )
                                                              ]
                                                              (abs
                                                                dead
                                                                (type)
                                                                [
                                                                  fail
                                                                  (abs
                                                                    e
                                                                    (type)
                                                                    (error e)
                                                                  )
                                                                ]
                                                              )
                                                            ]
                                                            (abs dead (type) GT)
                                                          ]
                                                          (all dead (type) dead)
                                                        }
                                                      )
                                                    )
                                                  ]
                                                  (abs
                                                    dead
                                                    (type)
                                                    {
                                                      [
                                                        [
                                                          [
                                                            {
                                                              [
                                                                {
                                                                  Extended_match
                                                                  a
                                                                }
                                                                ds
                                                              ]
                                                              (all
                                                                dead
                                                                (type)
                                                                Ordering
                                                              )
                                                            }
                                                            (lam
                                                              l
                                                              a
                                                              (abs
                                                                dead
                                                                (type)
                                                                {
                                                                  [
                                                                    [
                                                                      [
                                                                        {
                                                                          [
                                                                            {
                                                                              Extended_match
                                                                              a
                                                                            }
                                                                            ds
                                                                          ]
                                                                          (all
                                                                            dead
                                                                            (type)
                                                                            Ordering
                                                                          )
                                                                        }
                                                                        (lam
                                                                          r
                                                                          a
                                                                          (abs
                                                                            dead
                                                                            (type)
                                                                            [
                                                                              [
                                                                                [
                                                                                  {
                                                                                    compare
                                                                                    a
                                                                                  }
                                                                                  dOrd
                                                                                ]
                                                                                l
                                                                              ]
                                                                              r
                                                                            ]
                                                                          )
                                                                        )
                                                                      ]
                                                                      (abs
                                                                        dead
                                                                        (type)
                                                                        [
                                                                          fail
                                                                          (abs
                                                                            e
                                                                            (type)
                                                                            (error
                                                                              e
                                                                            )
                                                                          )
                                                                        ]
                                                                      )
                                                                    ]
                                                                    (abs
                                                                      dead
                                                                      (type)
                                                                      [
                                                                        fail
                                                                        (abs
                                                                          e
                                                                          (type)
                                                                          (error
                                                                            e
                                                                          )
                                                                        )
                                                                      ]
                                                                    )
                                                                  ]
                                                                  (all
                                                                    dead
                                                                    (type)
                                                                    dead
                                                                  )
                                                                }
                                                              )
                                                            )
                                                          ]
                                                          (abs
                                                            dead
                                                            (type)
                                                            [
                                                              fail
                                                              (abs
                                                                e
                                                                (type)
                                                                (error e)
                                                              )
                                                            ]
                                                          )
                                                        ]
                                                        (abs dead (type) GT)
                                                      ]
                                                      (all dead (type) dead)
                                                    }
                                                  )
                                                ]
                                                (abs dead (type) LT)
                                              ]
                                              (all dead (type) dead)
                                            }
                                          )
                                        )
                                        {
                                          [
                                            [
                                              [
                                                {
                                                  [ { Extended_match a } ds ]
                                                  (all dead (type) Ordering)
                                                }
                                                (lam
                                                  default_arg0
                                                  a
                                                  (abs
                                                    dead
                                                    (type)
                                                    [
                                                      fail
                                                      (abs e (type) (error e))
                                                    ]
                                                  )
                                                )
                                              ]
                                              (abs
                                                dead
                                                (type)
                                                [
                                                  fail (abs e (type) (error e))
                                                ]
                                              )
                                            ]
                                            (abs
                                              dead
                                              (type)
                                              {
                                                [
                                                  [
                                                    [
                                                      {
                                                        [
                                                          { Extended_match a }
                                                          ds
                                                        ]
                                                        (all
                                                          dead (type) Ordering
                                                        )
                                                      }
                                                      (lam
                                                        default_arg0
                                                        a
                                                        (abs
                                                          dead
                                                          (type)
                                                          [
                                                            fail
                                                            (abs
                                                              e (type) (error e)
                                                            )
                                                          ]
                                                        )
                                                      )
                                                    ]
                                                    (abs
                                                      dead
                                                      (type)
                                                      [
                                                        fail
                                                        (abs e (type) (error e))
                                                      ]
                                                    )
                                                  ]
                                                  (abs dead (type) EQ)
                                                ]
                                                (all dead (type) dead)
                                              }
                                            )
                                          ]
                                          (all dead (type) dead)
                                        }
                                      )
                                    )
                                  ]
                                  (all dead (type) dead)
                                }
                              )
                            )
                          ]
                          (abs
                            dead
                            (type)
                            {
                              [
                                [
                                  [
                                    {
                                      [ { Extended_match a } ds ]
                                      (all dead (type) Ordering)
                                    }
                                    (lam default_arg0 a (abs dead (type) LT))
                                  ]
                                  (abs dead (type) EQ)
                                ]
                                (abs dead (type) LT)
                              ]
                              (all dead (type) dead)
                            }
                          )
                        ]
                        (abs
                          dead
                          (type)
                          {
                            [
                              [
                                [
                                  {
                                    [ { Extended_match a } ds ]
                                    (all dead (type) Ordering)
                                  }
                                  (lam
                                    default_arg0
                                    a
                                    (abs
                                      dead
                                      (type)
                                      (let
                                        (nonrec)
                                        (termbind
                                          (strict)
                                          (vardecl
                                            fail (fun (all a (type) a) Ordering)
                                          )
                                          (lam
                                            ds
                                            (all a (type) a)
                                            {
                                              [
                                                [
                                                  [
                                                    {
                                                      [
                                                        { Extended_match a } ds
                                                      ]
                                                      (all dead (type) Ordering)
                                                    }
                                                    (lam
                                                      default_arg0
                                                      a
                                                      (abs
                                                        dead
                                                        (type)
                                                        {
                                                          [
                                                            [
                                                              [
                                                                {
                                                                  [
                                                                    {
                                                                      Extended_match
                                                                      a
                                                                    }
                                                                    ds
                                                                  ]
                                                                  (all
                                                                    dead
                                                                    (type)
                                                                    Ordering
                                                                  )
                                                                }
                                                                (lam
                                                                  l
                                                                  a
                                                                  (abs
                                                                    dead
                                                                    (type)
                                                                    {
                                                                      [
                                                                        [
                                                                          [
                                                                            {
                                                                              [
                                                                                {
                                                                                  Extended_match
                                                                                  a
                                                                                }
                                                                                ds
                                                                              ]
                                                                              (all
                                                                                dead
                                                                                (type)
                                                                                Ordering
                                                                              )
                                                                            }
                                                                            (lam
                                                                              r
                                                                              a
                                                                              (abs
                                                                                dead
                                                                                (type)
                                                                                [
                                                                                  [
                                                                                    [
                                                                                      {
                                                                                        compare
                                                                                        a
                                                                                      }
                                                                                      dOrd
                                                                                    ]
                                                                                    l
                                                                                  ]
                                                                                  r
                                                                                ]
                                                                              )
                                                                            )
                                                                          ]
                                                                          (abs
                                                                            dead
                                                                            (type)
                                                                            [
                                                                              fail
                                                                              (abs
                                                                                e
                                                                                (type)
                                                                                (error
                                                                                  e
                                                                                )
                                                                              )
                                                                            ]
                                                                          )
                                                                        ]
                                                                        (abs
                                                                          dead
                                                                          (type)
                                                                          [
                                                                            fail
                                                                            (abs
                                                                              e
                                                                              (type)
                                                                              (error
                                                                                e
                                                                              )
                                                                            )
                                                                          ]
                                                                        )
                                                                      ]
                                                                      (all
                                                                        dead
                                                                        (type)
                                                                        dead
                                                                      )
                                                                    }
                                                                  )
                                                                )
                                                              ]
                                                              (abs
                                                                dead
                                                                (type)
                                                                [
                                                                  fail
                                                                  (abs
                                                                    e
                                                                    (type)
                                                                    (error e)
                                                                  )
                                                                ]
                                                              )
                                                            ]
                                                            (abs dead (type) GT)
                                                          ]
                                                          (all dead (type) dead)
                                                        }
                                                      )
                                                    )
                                                  ]
                                                  (abs
                                                    dead
                                                    (type)
                                                    {
                                                      [
                                                        [
                                                          [
                                                            {
                                                              [
                                                                {
                                                                  Extended_match
                                                                  a
                                                                }
                                                                ds
                                                              ]
                                                              (all
                                                                dead
                                                                (type)
                                                                Ordering
                                                              )
                                                            }
                                                            (lam
                                                              l
                                                              a
                                                              (abs
                                                                dead
                                                                (type)
                                                                {
                                                                  [
                                                                    [
                                                                      [
                                                                        {
                                                                          [
                                                                            {
                                                                              Extended_match
                                                                              a
                                                                            }
                                                                            ds
                                                                          ]
                                                                          (all
                                                                            dead
                                                                            (type)
                                                                            Ordering
                                                                          )
                                                                        }
                                                                        (lam
                                                                          r
                                                                          a
                                                                          (abs
                                                                            dead
                                                                            (type)
                                                                            [
                                                                              [
                                                                                [
                                                                                  {
                                                                                    compare
                                                                                    a
                                                                                  }
                                                                                  dOrd
                                                                                ]
                                                                                l
                                                                              ]
                                                                              r
                                                                            ]
                                                                          )
                                                                        )
                                                                      ]
                                                                      (abs
                                                                        dead
                                                                        (type)
                                                                        [
                                                                          fail
                                                                          (abs
                                                                            e
                                                                            (type)
                                                                            (error
                                                                              e
                                                                            )
                                                                          )
                                                                        ]
                                                                      )
                                                                    ]
                                                                    (abs
                                                                      dead
                                                                      (type)
                                                                      [
                                                                        fail
                                                                        (abs
                                                                          e
                                                                          (type)
                                                                          (error
                                                                            e
                                                                          )
                                                                        )
                                                                      ]
                                                                    )
                                                                  ]
                                                                  (all
                                                                    dead
                                                                    (type)
                                                                    dead
                                                                  )
                                                                }
                                                              )
                                                            )
                                                          ]
                                                          (abs
                                                            dead
                                                            (type)
                                                            [
                                                              fail
                                                              (abs
                                                                e
                                                                (type)
                                                                (error e)
                                                              )
                                                            ]
                                                          )
                                                        ]
                                                        (abs dead (type) GT)
                                                      ]
                                                      (all dead (type) dead)
                                                    }
                                                  )
                                                ]
                                                (abs dead (type) LT)
                                              ]
                                              (all dead (type) dead)
                                            }
                                          )
                                        )
                                        {
                                          [
                                            [
                                              [
                                                {
                                                  [ { Extended_match a } ds ]
                                                  (all dead (type) Ordering)
                                                }
                                                (lam
                                                  default_arg0
                                                  a
                                                  (abs
                                                    dead
                                                    (type)
                                                    [
                                                      fail
                                                      (abs e (type) (error e))
                                                    ]
                                                  )
                                                )
                                              ]
                                              (abs
                                                dead
                                                (type)
                                                [
                                                  fail (abs e (type) (error e))
                                                ]
                                              )
                                            ]
                                            (abs
                                              dead
                                              (type)
                                              {
                                                [
                                                  [
                                                    [
                                                      {
                                                        [
                                                          { Extended_match a }
                                                          ds
                                                        ]
                                                        (all
                                                          dead (type) Ordering
                                                        )
                                                      }
                                                      (lam
                                                        default_arg0
                                                        a
                                                        (abs
                                                          dead
                                                          (type)
                                                          [
                                                            fail
                                                            (abs
                                                              e (type) (error e)
                                                            )
                                                          ]
                                                        )
                                                      )
                                                    ]
                                                    (abs
                                                      dead
                                                      (type)
                                                      [
                                                        fail
                                                        (abs e (type) (error e))
                                                      ]
                                                    )
                                                  ]
                                                  (abs dead (type) EQ)
                                                ]
                                                (all dead (type) dead)
                                              }
                                            )
                                          ]
                                          (all dead (type) dead)
                                        }
                                      )
                                    )
                                  )
                                ]
                                (abs dead (type) GT)
                              ]
                              (abs
                                dead
                                (type)
                                (let
                                  (nonrec)
                                  (termbind
                                    (strict)
                                    (vardecl
                                      fail (fun (all a (type) a) Ordering)
                                    )
                                    (lam
                                      ds
                                      (all a (type) a)
                                      {
                                        [
                                          [
                                            [
                                              {
                                                [ { Extended_match a } ds ]
                                                (all dead (type) Ordering)
                                              }
                                              (lam
                                                default_arg0
                                                a
                                                (abs
                                                  dead
                                                  (type)
                                                  {
                                                    [
                                                      [
                                                        [
                                                          {
                                                            [
                                                              {
                                                                Extended_match a
                                                              }
                                                              ds
                                                            ]
                                                            (all
                                                              dead
                                                              (type)
                                                              Ordering
                                                            )
                                                          }
                                                          (lam
                                                            l
                                                            a
                                                            (abs
                                                              dead
                                                              (type)
                                                              {
                                                                [
                                                                  [
                                                                    [
                                                                      {
                                                                        [
                                                                          {
                                                                            Extended_match
                                                                            a
                                                                          }
                                                                          ds
                                                                        ]
                                                                        (all
                                                                          dead
                                                                          (type)
                                                                          Ordering
                                                                        )
                                                                      }
                                                                      (lam
                                                                        r
                                                                        a
                                                                        (abs
                                                                          dead
                                                                          (type)
                                                                          [
                                                                            [
                                                                              [
                                                                                {
                                                                                  compare
                                                                                  a
                                                                                }
                                                                                dOrd
                                                                              ]
                                                                              l
                                                                            ]
                                                                            r
                                                                          ]
                                                                        )
                                                                      )
                                                                    ]
                                                                    (abs
                                                                      dead
                                                                      (type)
                                                                      [
                                                                        fail
                                                                        (abs
                                                                          e
                                                                          (type)
                                                                          (error
                                                                            e
                                                                          )
                                                                        )
                                                                      ]
                                                                    )
                                                                  ]
                                                                  (abs
                                                                    dead
                                                                    (type)
                                                                    [
                                                                      fail
                                                                      (abs
                                                                        e
                                                                        (type)
                                                                        (error
                                                                          e
                                                                        )
                                                                      )
                                                                    ]
                                                                  )
                                                                ]
                                                                (all
                                                                  dead
                                                                  (type)
                                                                  dead
                                                                )
                                                              }
                                                            )
                                                          )
                                                        ]
                                                        (abs
                                                          dead
                                                          (type)
                                                          [
                                                            fail
                                                            (abs
                                                              e (type) (error e)
                                                            )
                                                          ]
                                                        )
                                                      ]
                                                      (abs dead (type) GT)
                                                    ]
                                                    (all dead (type) dead)
                                                  }
                                                )
                                              )
                                            ]
                                            (abs
                                              dead
                                              (type)
                                              {
                                                [
                                                  [
                                                    [
                                                      {
                                                        [
                                                          { Extended_match a }
                                                          ds
                                                        ]
                                                        (all
                                                          dead (type) Ordering
                                                        )
                                                      }
                                                      (lam
                                                        l
                                                        a
                                                        (abs
                                                          dead
                                                          (type)
                                                          {
                                                            [
                                                              [
                                                                [
                                                                  {
                                                                    [
                                                                      {
                                                                        Extended_match
                                                                        a
                                                                      }
                                                                      ds
                                                                    ]
                                                                    (all
                                                                      dead
                                                                      (type)
                                                                      Ordering
                                                                    )
                                                                  }
                                                                  (lam
                                                                    r
                                                                    a
                                                                    (abs
                                                                      dead
                                                                      (type)
                                                                      [
                                                                        [
                                                                          [
                                                                            {
                                                                              compare
                                                                              a
                                                                            }
                                                                            dOrd
                                                                          ]
                                                                          l
                                                                        ]
                                                                        r
                                                                      ]
                                                                    )
                                                                  )
                                                                ]
                                                                (abs
                                                                  dead
                                                                  (type)
                                                                  [
                                                                    fail
                                                                    (abs
                                                                      e
                                                                      (type)
                                                                      (error e)
                                                                    )
                                                                  ]
                                                                )
                                                              ]
                                                              (abs
                                                                dead
                                                                (type)
                                                                [
                                                                  fail
                                                                  (abs
                                                                    e
                                                                    (type)
                                                                    (error e)
                                                                  )
                                                                ]
                                                              )
                                                            ]
                                                            (all
                                                              dead (type) dead
                                                            )
                                                          }
                                                        )
                                                      )
                                                    ]
                                                    (abs
                                                      dead
                                                      (type)
                                                      [
                                                        fail
                                                        (abs e (type) (error e))
                                                      ]
                                                    )
                                                  ]
                                                  (abs dead (type) GT)
                                                ]
                                                (all dead (type) dead)
                                              }
                                            )
                                          ]
                                          (abs dead (type) LT)
                                        ]
                                        (all dead (type) dead)
                                      }
                                    )
                                  )
                                  {
                                    [
                                      [
                                        [
                                          {
                                            [ { Extended_match a } ds ]
                                            (all dead (type) Ordering)
                                          }
                                          (lam
                                            default_arg0
                                            a
                                            (abs
                                              dead
                                              (type)
                                              [ fail (abs e (type) (error e)) ]
                                            )
                                          )
                                        ]
                                        (abs
                                          dead
                                          (type)
                                          [ fail (abs e (type) (error e)) ]
                                        )
                                      ]
                                      (abs
                                        dead
                                        (type)
                                        {
                                          [
                                            [
                                              [
                                                {
                                                  [ { Extended_match a } ds ]
                                                  (all dead (type) Ordering)
                                                }
                                                (lam
                                                  default_arg0
                                                  a
                                                  (abs
                                                    dead
                                                    (type)
                                                    [
                                                      fail
                                                      (abs e (type) (error e))
                                                    ]
                                                  )
                                                )
                                              ]
                                              (abs
                                                dead
                                                (type)
                                                [
                                                  fail (abs e (type) (error e))
                                                ]
                                              )
                                            ]
                                            (abs dead (type) EQ)
                                          ]
                                          (all dead (type) dead)
                                        }
                                      )
                                    ]
                                    (all dead (type) dead)
                                  }
                                )
                              )
                            ]
                            (all dead (type) dead)
                          }
                        )
                      ]
                      (all dead (type) dead)
                    }
                  )
                )
              )
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            wc
            (all
              a
              (type)
              (fun
                [ Ord a ]
                (fun
                  [ Extended a ] (fun Bool (fun [ Extended a ] (fun Bool Bool)))
                )
              )
            )
          )
          (abs
            a
            (type)
            (lam
              w
              [ Ord a ]
              (lam
                ww
                [ Extended a ]
                (lam
                  ww
                  Bool
                  (lam
                    ww
                    [ Extended a ]
                    (lam
                      ww
                      Bool
                      {
                        [
                          [
                            [
                              {
                                [
                                  Ordering_match
                                  [ [ [ { hull_ccompare a } w ] ww ] ww ]
                                ]
                                (all dead (type) Bool)
                              }
                              (abs
                                dead
                                (type)
                                {
                                  [
                                    [
                                      {
                                        [ Bool_match ww ] (all dead (type) Bool)
                                      }
                                      (abs dead (type) ww)
                                    ]
                                    (abs dead (type) True)
                                  ]
                                  (all dead (type) dead)
                                }
                              )
                            ]
                            (abs dead (type) False)
                          ]
                          (abs dead (type) True)
                        ]
                        (all dead (type) dead)
                      }
                    )
                  )
                )
              )
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            fOrdUpperBound0_c
            (all
              a
              (type)
              (fun [ Ord a ] (fun [ UpperBound a ] (fun [ UpperBound a ] Bool)))
            )
          )
          (abs
            a
            (type)
            (lam
              w
              [ Ord a ]
              (lam
                w
                [ UpperBound a ]
                (lam
                  w
                  [ UpperBound a ]
                  [
                    { [ { UpperBound_match a } w ] Bool }
                    (lam
                      ww
                      [ Extended a ]
                      (lam
                        ww
                        Bool
                        [
                          { [ { UpperBound_match a } w ] Bool }
                          (lam
                            ww
                            [ Extended a ]
                            (lam
                              ww Bool [ [ [ [ [ { wc a } w ] ww ] ww ] ww ] ww ]
                            )
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            wcontains
            (all
              a
              (type)
              (fun
                [ Ord a ]
                (fun
                  [ Extended a ]
                  (fun
                    Bool
                    (fun
                      [ UpperBound a ]
                      (fun
                        [ Extended a ] (fun Bool (fun [ UpperBound a ] Bool))
                      )
                    )
                  )
                )
              )
            )
          )
          (abs
            a
            (type)
            (lam
              w
              [ Ord a ]
              (lam
                ww
                [ Extended a ]
                (lam
                  ww
                  Bool
                  (lam
                    ww
                    [ UpperBound a ]
                    (lam
                      ww
                      [ Extended a ]
                      (lam
                        ww
                        Bool
                        (lam
                          ww
                          [ UpperBound a ]
                          {
                            [
                              [
                                [
                                  {
                                    [
                                      Ordering_match
                                      [ [ [ { hull_ccompare a } w ] ww ] ww ]
                                    ]
                                    (all dead (type) Bool)
                                  }
                                  (abs
                                    dead
                                    (type)
                                    {
                                      [
                                        [
                                          {
                                            [ Bool_match ww ]
                                            (all dead (type) Bool)
                                          }
                                          (abs
                                            dead
                                            (type)
                                            {
                                              [
                                                [
                                                  {
                                                    [ Bool_match ww ]
                                                    (all dead (type) Bool)
                                                  }
                                                  (abs
                                                    dead
                                                    (type)
                                                    [
                                                      [
                                                        [
                                                          {
                                                            fOrdUpperBound0_c a
                                                          }
                                                          w
                                                        ]
                                                        ww
                                                      ]
                                                      ww
                                                    ]
                                                  )
                                                ]
                                                (abs dead (type) False)
                                              ]
                                              (all dead (type) dead)
                                            }
                                          )
                                        ]
                                        (abs
                                          dead
                                          (type)
                                          [
                                            [ [ { fOrdUpperBound0_c a } w ] ww ]
                                            ww
                                          ]
                                        )
                                      ]
                                      (all dead (type) dead)
                                    }
                                  )
                                ]
                                (abs dead (type) False)
                              ]
                              (abs
                                dead
                                (type)
                                [ [ [ { fOrdUpperBound0_c a } w ] ww ] ww ]
                              )
                            ]
                            (all dead (type) dead)
                          }
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            fOrdInteger_ccompare
            (fun (con integer) (fun (con integer) Ordering))
          )
          (lam
            x
            (con integer)
            (lam
              y
              (con integer)
              {
                [
                  [
                    {
                      [
                        Bool_match
                        [
                          [
                            [
                              { (builtin ifThenElse) Bool }
                              [ [ (builtin equalsInteger) x ] y ]
                            ]
                            True
                          ]
                          False
                        ]
                      ]
                      (all dead (type) Ordering)
                    }
                    (abs dead (type) EQ)
                  ]
                  (abs
                    dead
                    (type)
                    {
                      [
                        [
                          {
                            [
                              Bool_match
                              [
                                [
                                  [
                                    { (builtin ifThenElse) Bool }
                                    [ [ (builtin lessThanEqualsInteger) x ] y ]
                                  ]
                                  True
                                ]
                                False
                              ]
                            ]
                            (all dead (type) Ordering)
                          }
                          (abs dead (type) LT)
                        ]
                        (abs dead (type) GT)
                      ]
                      (all dead (type) dead)
                    }
                  )
                ]
                (all dead (type) dead)
              }
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            fOrdInteger_cmax
            (fun (con integer) (fun (con integer) (con integer)))
          )
          (lam
            x
            (con integer)
            (lam
              y
              (con integer)
              {
                [
                  [
                    {
                      [
                        Bool_match
                        [
                          [
                            [
                              { (builtin ifThenElse) Bool }
                              [ [ (builtin lessThanEqualsInteger) x ] y ]
                            ]
                            True
                          ]
                          False
                        ]
                      ]
                      (all dead (type) (con integer))
                    }
                    (abs dead (type) y)
                  ]
                  (abs dead (type) x)
                ]
                (all dead (type) dead)
              }
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            fOrdInteger_cmin
            (fun (con integer) (fun (con integer) (con integer)))
          )
          (lam
            x
            (con integer)
            (lam
              y
              (con integer)
              {
                [
                  [
                    {
                      [
                        Bool_match
                        [
                          [
                            [
                              { (builtin ifThenElse) Bool }
                              [ [ (builtin lessThanEqualsInteger) x ] y ]
                            ]
                            True
                          ]
                          False
                        ]
                      ]
                      (all dead (type) (con integer))
                    }
                    (abs dead (type) x)
                  ]
                  (abs dead (type) y)
                ]
                (all dead (type) dead)
              }
            )
          )
        )
        (termbind
          (strict)
          (vardecl equalsInteger (fun (con integer) (fun (con integer) Bool)))
          (lam
            x
            (con integer)
            (lam
              y
              (con integer)
              [
                [
                  [
                    { (builtin ifThenElse) Bool }
                    [ [ (builtin equalsInteger) x ] y ]
                  ]
                  True
                ]
                False
              ]
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            greaterThanEqualsInteger
            (fun (con integer) (fun (con integer) Bool))
          )
          (lam
            x
            (con integer)
            (lam
              y
              (con integer)
              [
                [
                  [
                    { (builtin ifThenElse) Bool }
                    [ [ (builtin lessThanInteger) x ] y ]
                  ]
                  False
                ]
                True
              ]
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            greaterThanInteger (fun (con integer) (fun (con integer) Bool))
          )
          (lam
            x
            (con integer)
            (lam
              y
              (con integer)
              [
                [
                  [
                    { (builtin ifThenElse) Bool }
                    [ [ (builtin lessThanEqualsInteger) x ] y ]
                  ]
                  False
                ]
                True
              ]
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            lessThanEqualsInteger (fun (con integer) (fun (con integer) Bool))
          )
          (lam
            x
            (con integer)
            (lam
              y
              (con integer)
              [
                [
                  [
                    { (builtin ifThenElse) Bool }
                    [ [ (builtin lessThanEqualsInteger) x ] y ]
                  ]
                  True
                ]
                False
              ]
            )
          )
        )
        (termbind
          (strict)
          (vardecl lessThanInteger (fun (con integer) (fun (con integer) Bool)))
          (lam
            x
            (con integer)
            (lam
              y
              (con integer)
              [
                [
                  [
                    { (builtin ifThenElse) Bool }
                    [ [ (builtin lessThanInteger) x ] y ]
                  ]
                  True
                ]
                False
              ]
            )
          )
        )
        (termbind
          (nonstrict)
          (vardecl fOrdPOSIXTime [ Ord (con integer) ])
          [
            [
              [
                [
                  [
                    [
                      [
                        [ { CConsOrd (con integer) } equalsInteger ]
                        fOrdInteger_ccompare
                      ]
                      lessThanInteger
                    ]
                    lessThanEqualsInteger
                  ]
                  greaterThanInteger
                ]
                greaterThanEqualsInteger
              ]
              fOrdInteger_cmax
            ]
            fOrdInteger_cmin
          ]
        )
        (datatypebind
          (datatype
            (tyvardecl Monoid (fun (type) (type)))
            (tyvardecl a (type))
            Monoid_match
            (vardecl
              CConsMonoid
              (fun [ (lam a (type) (fun a (fun a a))) a ] (fun a [ Monoid a ]))
            )
          )
        )
        (termbind
          (strict)
          (vardecl
            p1Monoid
            (all
              a (type) (fun [ Monoid a ] [ (lam a (type) (fun a (fun a a))) a ])
            )
          )
          (abs
            a
            (type)
            (lam
              v
              [ Monoid a ]
              [
                {
                  [ { Monoid_match a } v ]
                  [ (lam a (type) (fun a (fun a a))) a ]
                }
                (lam v [ (lam a (type) (fun a (fun a a))) a ] (lam v a v))
              ]
            )
          )
        )
        (termbind
          (strict)
          (vardecl mempty (all a (type) (fun [ Monoid a ] a)))
          (abs
            a
            (type)
            (lam
              v
              [ Monoid a ]
              [
                { [ { Monoid_match a } v ] a }
                (lam v [ (lam a (type) (fun a (fun a a))) a ] (lam v a v))
              ]
            )
          )
        )
        (let
          (rec)
          (termbind
            (strict)
            (vardecl
              fFoldableNil_cfoldMap
              (all
                m
                (type)
                (all
                  a (type) (fun [ Monoid m ] (fun (fun a m) (fun [ List a ] m)))
                )
              )
            )
            (abs
              m
              (type)
              (abs
                a
                (type)
                (lam
                  dMonoid
                  [ Monoid m ]
                  (let
                    (nonrec)
                    (termbind
                      (nonstrict)
                      (vardecl
                        dSemigroup [ (lam a (type) (fun a (fun a a))) m ]
                      )
                      [ { p1Monoid m } dMonoid ]
                    )
                    (lam
                      ds
                      (fun a m)
                      (lam
                        ds
                        [ List a ]
                        {
                          [
                            [
                              { [ { Nil_match a } ds ] (all dead (type) m) }
                              (abs dead (type) [ { mempty m } dMonoid ])
                            ]
                            (lam
                              x
                              a
                              (lam
                                xs
                                [ List a ]
                                (abs
                                  dead
                                  (type)
                                  [
                                    [ dSemigroup [ ds x ] ]
                                    [
                                      [
                                        [
                                          { { fFoldableNil_cfoldMap m } a }
                                          dMonoid
                                        ]
                                        ds
                                      ]
                                      xs
                                    ]
                                  ]
                                )
                              )
                            )
                          ]
                          (all dead (type) dead)
                        }
                      )
                    )
                  )
                )
              )
            )
          )
          (let
            (nonrec)
            (termbind
              (strict)
              (vardecl
                fSemigroupFirst_c
                (all
                  a
                  (type)
                  (fun
                    [ (lam a (type) [ Maybe a ]) a ]
                    (fun
                      [ (lam a (type) [ Maybe a ]) a ]
                      [ (lam a (type) [ Maybe a ]) a ]
                    )
                  )
                )
              )
              (abs
                a
                (type)
                (lam
                  ds
                  [ (lam a (type) [ Maybe a ]) a ]
                  (lam
                    b
                    [ (lam a (type) [ Maybe a ]) a ]
                    {
                      [
                        [
                          {
                            [ { Maybe_match a } ds ]
                            (all dead (type) [ (lam a (type) [ Maybe a ]) a ])
                          }
                          (lam ipv a (abs dead (type) ds))
                        ]
                        (abs dead (type) b)
                      ]
                      (all dead (type) dead)
                    }
                  )
                )
              )
            )
            (termbind
              (strict)
              (vardecl
                fMonoidFirst
                (all a (type) [ Monoid [ (lam a (type) [ Maybe a ]) a ] ])
              )
              (abs
                a
                (type)
                [
                  [
                    { CConsMonoid [ (lam a (type) [ Maybe a ]) a ] }
                    { fSemigroupFirst_c a }
                  ]
                  { Nothing a }
                ]
              )
            )
            (termbind
              (strict)
              (vardecl
                wtxSignedBy
                (fun [ List (con bytestring) ] (fun (con bytestring) Bool))
              )
              (lam
                ww
                [ List (con bytestring) ]
                (lam
                  w
                  (con bytestring)
                  {
                    [
                      [
                        {
                          [
                            { Maybe_match (con bytestring) }
                            [
                              [
                                [
                                  {
                                    {
                                      fFoldableNil_cfoldMap
                                      [
                                        (lam a (type) [ Maybe a ])
                                        (con bytestring)
                                      ]
                                    }
                                    (con bytestring)
                                  }
                                  { fMonoidFirst (con bytestring) }
                                ]
                                (lam
                                  x
                                  (con bytestring)
                                  {
                                    [
                                      [
                                        {
                                          [
                                            Bool_match
                                            [
                                              [
                                                [
                                                  { (builtin ifThenElse) Bool }
                                                  [
                                                    [
                                                      (builtin equalsByteString)
                                                      w
                                                    ]
                                                    x
                                                  ]
                                                ]
                                                True
                                              ]
                                              False
                                            ]
                                          ]
                                          (all
                                            dead
                                            (type)
                                            [ Maybe (con bytestring) ]
                                          )
                                        }
                                        (abs
                                          dead
                                          (type)
                                          [ { Just (con bytestring) } x ]
                                        )
                                      ]
                                      (abs
                                        dead (type) { Nothing (con bytestring) }
                                      )
                                    ]
                                    (all dead (type) dead)
                                  }
                                )
                              ]
                              ww
                            ]
                          ]
                          (all dead (type) Bool)
                        }
                        (lam ds (con bytestring) (abs dead (type) True))
                      ]
                      (abs dead (type) False)
                    ]
                    (all dead (type) dead)
                  }
                )
              )
            )
            (termbind
              (strict)
              (vardecl
                wvalidCollection
                (fun
                  Campaign
                  (fun
                    [ Extended (con integer) ]
                    (fun
                      Bool
                      (fun
                        [ UpperBound (con integer) ]
                        (fun [ List (con bytestring) ] Bool)
                      )
                    )
                  )
                )
              )
              (lam
                w
                Campaign
                (lam
                  ww
                  [ Extended (con integer) ]
                  (lam
                    ww
                    Bool
                    (lam
                      ww
                      [ UpperBound (con integer) ]
                      (lam
                        ww
                        [ List (con bytestring) ]
                        [
                          {
                            [
                              {
                                { UTuple2_match [ LowerBound (con integer) ] }
                                [ UpperBound (con integer) ]
                              }
                              [ wcollectionRange w ]
                            ]
                            Bool
                          }
                          (lam
                            ww
                            [ LowerBound (con integer) ]
                            (lam
                              ww
                              [ UpperBound (con integer) ]
                              [
                                {
                                  [ { LowerBound_match (con integer) } ww ] Bool
                                }
                                (lam
                                  ww
                                  [ Extended (con integer) ]
                                  (lam
                                    ww
                                    Bool
                                    {
                                      [
                                        [
                                          {
                                            [
                                              Bool_match
                                              [
                                                [
                                                  [
                                                    [
                                                      [
                                                        [
                                                          [
                                                            {
                                                              wcontains
                                                              (con integer)
                                                            }
                                                            fOrdPOSIXTime
                                                          ]
                                                          ww
                                                        ]
                                                        ww
                                                      ]
                                                      ww
                                                    ]
                                                    ww
                                                  ]
                                                  ww
                                                ]
                                                ww
                                              ]
                                            ]
                                            (all dead (type) Bool)
                                          }
                                          (abs
                                            dead
                                            (type)
                                            [
                                              [ wtxSignedBy ww ]
                                              [
                                                {
                                                  [ Campaign_match w ]
                                                  (con bytestring)
                                                }
                                                (lam
                                                  ds
                                                  (con integer)
                                                  (lam
                                                    ds
                                                    (con integer)
                                                    (lam ds (con bytestring) ds)
                                                  )
                                                )
                                              ]
                                            ]
                                          )
                                        ]
                                        (abs dead (type) False)
                                      ]
                                      (all dead (type) dead)
                                    }
                                  )
                                )
                              ]
                            )
                          )
                        ]
                      )
                    )
                  )
                )
              )
            )
            (termbind
              (strict)
              (vardecl validCollection (fun Campaign (fun TxInfo Bool)))
              (lam
                w
                Campaign
                (lam
                  w
                  TxInfo
                  [
                    { [ TxInfo_match w ] Bool }
                    (lam
                      ww
                      [ List TxInInfo ]
                      (lam
                        ww
                        [ List TxOut ]
                        (lam
                          ww
                          [
                            [
                              (lam
                                k
                                (type)
                                (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                              )
                              (con bytestring)
                            ]
                            [
                              [
                                (lam
                                  k
                                  (type)
                                  (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                                )
                                (con bytestring)
                              ]
                              (con integer)
                            ]
                          ]
                          (lam
                            ww
                            [
                              [
                                (lam
                                  k
                                  (type)
                                  (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                                )
                                (con bytestring)
                              ]
                              [
                                [
                                  (lam
                                    k
                                    (type)
                                    (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                                  )
                                  (con bytestring)
                                ]
                                (con integer)
                              ]
                            ]
                            (lam
                              ww
                              [ List DCert ]
                              (lam
                                ww
                                [
                                  List
                                  [ [ Tuple2 StakingCredential ] (con integer) ]
                                ]
                                (lam
                                  ww
                                  [ Interval (con integer) ]
                                  (lam
                                    ww
                                    [ List (con bytestring) ]
                                    (lam
                                      ww
                                      [
                                        List
                                        [
                                          [ Tuple2 (con bytestring) ] (con data)
                                        ]
                                      ]
                                      (lam
                                        ww
                                        (con bytestring)
                                        [
                                          {
                                            [
                                              { Interval_match (con integer) }
                                              ww
                                            ]
                                            Bool
                                          }
                                          (lam
                                            ww
                                            [ LowerBound (con integer) ]
                                            (lam
                                              ww
                                              [ UpperBound (con integer) ]
                                              [
                                                {
                                                  [
                                                    {
                                                      LowerBound_match
                                                      (con integer)
                                                    }
                                                    ww
                                                  ]
                                                  Bool
                                                }
                                                (lam
                                                  ww
                                                  [ Extended (con integer) ]
                                                  (lam
                                                    ww
                                                    Bool
                                                    [
                                                      [
                                                        [
                                                          [
                                                            [
                                                              wvalidCollection w
                                                            ]
                                                            ww
                                                          ]
                                                          ww
                                                        ]
                                                        ww
                                                      ]
                                                      ww
                                                    ]
                                                  )
                                                )
                                              ]
                                            )
                                          )
                                        ]
                                      )
                                    )
                                  )
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  ]
                )
              )
            )
            (termbind
              (strict)
              (vardecl
                wvalidRefund
                (fun
                  Campaign
                  (fun
                    (con bytestring)
                    (fun
                      [ Extended (con integer) ]
                      (fun
                        Bool
                        (fun
                          [ UpperBound (con integer) ]
                          (fun [ List (con bytestring) ] Bool)
                        )
                      )
                    )
                  )
                )
              )
              (lam
                w
                Campaign
                (lam
                  w
                  (con bytestring)
                  (lam
                    ww
                    [ Extended (con integer) ]
                    (lam
                      ww
                      Bool
                      (lam
                        ww
                        [ UpperBound (con integer) ]
                        (lam
                          ww
                          [ List (con bytestring) ]
                          {
                            [
                              [
                                [
                                  {
                                    [
                                      Ordering_match
                                      [
                                        [
                                          [
                                            { hull_ccompare (con integer) }
                                            fOrdPOSIXTime
                                          ]
                                          [
                                            { Finite (con integer) }
                                            [
                                              {
                                                [ Campaign_match w ]
                                                (con integer)
                                              }
                                              (lam
                                                ds
                                                (con integer)
                                                (lam
                                                  ds
                                                  (con integer)
                                                  (lam ds (con bytestring) ds)
                                                )
                                              )
                                            ]
                                          ]
                                        ]
                                        ww
                                      ]
                                    ]
                                    (all dead (type) Bool)
                                  }
                                  (abs
                                    dead
                                    (type)
                                    {
                                      [
                                        [
                                          {
                                            [ Bool_match ww ]
                                            (all dead (type) Bool)
                                          }
                                          (abs
                                            dead
                                            (type)
                                            [
                                              {
                                                [
                                                  {
                                                    UpperBound_match
                                                    (con integer)
                                                  }
                                                  ww
                                                ]
                                                Bool
                                              }
                                              (lam
                                                ww
                                                [ Extended (con integer) ]
                                                (lam
                                                  ww
                                                  Bool
                                                  {
                                                    [
                                                      [
                                                        [
                                                          {
                                                            [
                                                              {
                                                                Extended_match
                                                                (con integer)
                                                              }
                                                              ww
                                                            ]
                                                            (all
                                                              dead (type) Bool
                                                            )
                                                          }
                                                          (lam
                                                            default_arg0
                                                            (con integer)
                                                            (abs
                                                              dead
                                                              (type)
                                                              {
                                                                [
                                                                  [
                                                                    [
                                                                      {
                                                                        [
                                                                          {
                                                                            Extended_match
                                                                            (con
                                                                              integer
                                                                            )
                                                                          }
                                                                          ww
                                                                        ]
                                                                        (all
                                                                          dead
                                                                          (type)
                                                                          Bool
                                                                        )
                                                                      }
                                                                      (lam
                                                                        default_arg0
                                                                        (con
                                                                          integer
                                                                        )
                                                                        (abs
                                                                          dead
                                                                          (type)
                                                                          [
                                                                            [
                                                                              wtxSignedBy
                                                                              ww
                                                                            ]
                                                                            w
                                                                          ]
                                                                        )
                                                                      )
                                                                    ]
                                                                    (abs
                                                                      dead
                                                                      (type)
                                                                      [
                                                                        [
                                                                          wtxSignedBy
                                                                          ww
                                                                        ]
                                                                        w
                                                                      ]
                                                                    )
                                                                  ]
                                                                  (abs
                                                                    dead
                                                                    (type)
                                                                    [
                                                                      [
                                                                        wtxSignedBy
                                                                        ww
                                                                      ]
                                                                      w
                                                                    ]
                                                                  )
                                                                ]
                                                                (all
                                                                  dead
                                                                  (type)
                                                                  dead
                                                                )
                                                              }
                                                            )
                                                          )
                                                        ]
                                                        (abs
                                                          dead
                                                          (type)
                                                          [
                                                            [ wtxSignedBy ww ] w
                                                          ]
                                                        )
                                                      ]
                                                      (abs
                                                        dead
                                                        (type)
                                                        {
                                                          [
                                                            [
                                                              [
                                                                {
                                                                  [
                                                                    {
                                                                      Extended_match
                                                                      (con
                                                                        integer
                                                                      )
                                                                    }
                                                                    ww
                                                                  ]
                                                                  (all
                                                                    dead
                                                                    (type)
                                                                    Bool
                                                                  )
                                                                }
                                                                (lam
                                                                  default_arg0
                                                                  (con integer)
                                                                  (abs
                                                                    dead
                                                                    (type)
                                                                    [
                                                                      [
                                                                        wtxSignedBy
                                                                        ww
                                                                      ]
                                                                      w
                                                                    ]
                                                                  )
                                                                )
                                                              ]
                                                              (abs
                                                                dead
                                                                (type)
                                                                [
                                                                  [
                                                                    wtxSignedBy
                                                                    ww
                                                                  ]
                                                                  w
                                                                ]
                                                              )
                                                            ]
                                                            (abs
                                                              dead
                                                              (type)
                                                              [
                                                                [
                                                                  wtxSignedBy ww
                                                                ]
                                                                w
                                                              ]
                                                            )
                                                          ]
                                                          (all dead (type) dead)
                                                        }
                                                      )
                                                    ]
                                                    (all dead (type) dead)
                                                  }
                                                )
                                              )
                                            ]
                                          )
                                        ]
                                        (abs
                                          dead
                                          (type)
                                          [
                                            {
                                              [
                                                {
                                                  UpperBound_match (con integer)
                                                }
                                                ww
                                              ]
                                              Bool
                                            }
                                            (lam
                                              ww
                                              [ Extended (con integer) ]
                                              (lam
                                                ww
                                                Bool
                                                {
                                                  [
                                                    [
                                                      [
                                                        {
                                                          [
                                                            {
                                                              Extended_match
                                                              (con integer)
                                                            }
                                                            ww
                                                          ]
                                                          (all dead (type) Bool)
                                                        }
                                                        (lam
                                                          default_arg0
                                                          (con integer)
                                                          (abs
                                                            dead
                                                            (type)
                                                            {
                                                              [
                                                                [
                                                                  [
                                                                    {
                                                                      [
                                                                        {
                                                                          Extended_match
                                                                          (con
                                                                            integer
                                                                          )
                                                                        }
                                                                        ww
                                                                      ]
                                                                      (all
                                                                        dead
                                                                        (type)
                                                                        Bool
                                                                      )
                                                                    }
                                                                    (lam
                                                                      default_arg0
                                                                      (con
                                                                        integer
                                                                      )
                                                                      (abs
                                                                        dead
                                                                        (type)
                                                                        [
                                                                          [
                                                                            wtxSignedBy
                                                                            ww
                                                                          ]
                                                                          w
                                                                        ]
                                                                      )
                                                                    )
                                                                  ]
                                                                  (abs
                                                                    dead
                                                                    (type)
                                                                    [
                                                                      [
                                                                        wtxSignedBy
                                                                        ww
                                                                      ]
                                                                      w
                                                                    ]
                                                                  )
                                                                ]
                                                                (abs
                                                                  dead
                                                                  (type)
                                                                  [
                                                                    [
                                                                      wtxSignedBy
                                                                      ww
                                                                    ]
                                                                    w
                                                                  ]
                                                                )
                                                              ]
                                                              (all
                                                                dead (type) dead
                                                              )
                                                            }
                                                          )
                                                        )
                                                      ]
                                                      (abs
                                                        dead
                                                        (type)
                                                        [ [ wtxSignedBy ww ] w ]
                                                      )
                                                    ]
                                                    (abs
                                                      dead
                                                      (type)
                                                      {
                                                        [
                                                          [
                                                            [
                                                              {
                                                                [
                                                                  {
                                                                    Extended_match
                                                                    (con
                                                                      integer
                                                                    )
                                                                  }
                                                                  ww
                                                                ]
                                                                (all
                                                                  dead
                                                                  (type)
                                                                  Bool
                                                                )
                                                              }
                                                              (lam
                                                                default_arg0
                                                                (con integer)
                                                                (abs
                                                                  dead
                                                                  (type)
                                                                  [
                                                                    [
                                                                      wtxSignedBy
                                                                      ww
                                                                    ]
                                                                    w
                                                                  ]
                                                                )
                                                              )
                                                            ]
                                                            (abs
                                                              dead
                                                              (type)
                                                              [
                                                                [
                                                                  wtxSignedBy ww
                                                                ]
                                                                w
                                                              ]
                                                            )
                                                          ]
                                                          (abs
                                                            dead
                                                            (type)
                                                            [
                                                              [ wtxSignedBy ww ]
                                                              w
                                                            ]
                                                          )
                                                        ]
                                                        (all dead (type) dead)
                                                      }
                                                    )
                                                  ]
                                                  (all dead (type) dead)
                                                }
                                              )
                                            )
                                          ]
                                        )
                                      ]
                                      (all dead (type) dead)
                                    }
                                  )
                                ]
                                (abs dead (type) False)
                              ]
                              (abs
                                dead
                                (type)
                                [
                                  {
                                    [ { UpperBound_match (con integer) } ww ]
                                    Bool
                                  }
                                  (lam
                                    ww
                                    [ Extended (con integer) ]
                                    (lam
                                      ww
                                      Bool
                                      {
                                        [
                                          [
                                            [
                                              {
                                                [
                                                  {
                                                    Extended_match (con integer)
                                                  }
                                                  ww
                                                ]
                                                (all dead (type) Bool)
                                              }
                                              (lam
                                                default_arg0
                                                (con integer)
                                                (abs
                                                  dead
                                                  (type)
                                                  {
                                                    [
                                                      [
                                                        [
                                                          {
                                                            [
                                                              {
                                                                Extended_match
                                                                (con integer)
                                                              }
                                                              ww
                                                            ]
                                                            (all
                                                              dead (type) Bool
                                                            )
                                                          }
                                                          (lam
                                                            default_arg0
                                                            (con integer)
                                                            (abs
                                                              dead
                                                              (type)
                                                              [
                                                                [
                                                                  wtxSignedBy ww
                                                                ]
                                                                w
                                                              ]
                                                            )
                                                          )
                                                        ]
                                                        (abs
                                                          dead
                                                          (type)
                                                          [
                                                            [ wtxSignedBy ww ] w
                                                          ]
                                                        )
                                                      ]
                                                      (abs
                                                        dead
                                                        (type)
                                                        [ [ wtxSignedBy ww ] w ]
                                                      )
                                                    ]
                                                    (all dead (type) dead)
                                                  }
                                                )
                                              )
                                            ]
                                            (abs
                                              dead
                                              (type)
                                              [ [ wtxSignedBy ww ] w ]
                                            )
                                          ]
                                          (abs
                                            dead
                                            (type)
                                            {
                                              [
                                                [
                                                  [
                                                    {
                                                      [
                                                        {
                                                          Extended_match
                                                          (con integer)
                                                        }
                                                        ww
                                                      ]
                                                      (all dead (type) Bool)
                                                    }
                                                    (lam
                                                      default_arg0
                                                      (con integer)
                                                      (abs
                                                        dead
                                                        (type)
                                                        [ [ wtxSignedBy ww ] w ]
                                                      )
                                                    )
                                                  ]
                                                  (abs
                                                    dead
                                                    (type)
                                                    [ [ wtxSignedBy ww ] w ]
                                                  )
                                                ]
                                                (abs
                                                  dead
                                                  (type)
                                                  [ [ wtxSignedBy ww ] w ]
                                                )
                                              ]
                                              (all dead (type) dead)
                                            }
                                          )
                                        ]
                                        (all dead (type) dead)
                                      }
                                    )
                                  )
                                ]
                              )
                            ]
                            (all dead (type) dead)
                          }
                        )
                      )
                    )
                  )
                )
              )
            )
            (termbind
              (strict)
              (vardecl
                validRefund
                (fun Campaign (fun (con bytestring) (fun TxInfo Bool)))
              )
              (lam
                w
                Campaign
                (lam
                  w
                  (con bytestring)
                  (lam
                    w
                    TxInfo
                    [
                      { [ TxInfo_match w ] Bool }
                      (lam
                        ww
                        [ List TxInInfo ]
                        (lam
                          ww
                          [ List TxOut ]
                          (lam
                            ww
                            [
                              [
                                (lam
                                  k
                                  (type)
                                  (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                                )
                                (con bytestring)
                              ]
                              [
                                [
                                  (lam
                                    k
                                    (type)
                                    (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                                  )
                                  (con bytestring)
                                ]
                                (con integer)
                              ]
                            ]
                            (lam
                              ww
                              [
                                [
                                  (lam
                                    k
                                    (type)
                                    (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                                  )
                                  (con bytestring)
                                ]
                                [
                                  [
                                    (lam
                                      k
                                      (type)
                                      (lam v (type) [ List [ [ Tuple2 k ] v ] ])
                                    )
                                    (con bytestring)
                                  ]
                                  (con integer)
                                ]
                              ]
                              (lam
                                ww
                                [ List DCert ]
                                (lam
                                  ww
                                  [
                                    List
                                    [
                                      [ Tuple2 StakingCredential ] (con integer)
                                    ]
                                  ]
                                  (lam
                                    ww
                                    [ Interval (con integer) ]
                                    (lam
                                      ww
                                      [ List (con bytestring) ]
                                      (lam
                                        ww
                                        [
                                          List
                                          [
                                            [ Tuple2 (con bytestring) ]
                                            (con data)
                                          ]
                                        ]
                                        (lam
                                          ww
                                          (con bytestring)
                                          [
                                            {
                                              [
                                                { Interval_match (con integer) }
                                                ww
                                              ]
                                              Bool
                                            }
                                            (lam
                                              ww
                                              [ LowerBound (con integer) ]
                                              (lam
                                                ww
                                                [ UpperBound (con integer) ]
                                                [
                                                  {
                                                    [
                                                      {
                                                        LowerBound_match
                                                        (con integer)
                                                      }
                                                      ww
                                                    ]
                                                    Bool
                                                  }
                                                  (lam
                                                    ww
                                                    [ Extended (con integer) ]
                                                    (lam
                                                      ww
                                                      Bool
                                                      [
                                                        [
                                                          [
                                                            [
                                                              [
                                                                [
                                                                  wvalidRefund w
                                                                ]
                                                                w
                                                              ]
                                                              ww
                                                            ]
                                                            ww
                                                          ]
                                                          ww
                                                        ]
                                                        ww
                                                      ]
                                                    )
                                                  )
                                                ]
                                              )
                                            )
                                          ]
                                        )
                                      )
                                    )
                                  )
                                )
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            )
            (termbind
              (strict)
              (vardecl
                mkValidator
                (fun
                  Campaign
                  (fun
                    (con bytestring)
                    (fun CampaignAction (fun ScriptContext Bool))
                  )
                )
              )
              (lam
                c
                Campaign
                (lam
                  con
                  (con bytestring)
                  (lam
                    act
                    CampaignAction
                    (lam
                      ds
                      ScriptContext
                      [
                        { [ ScriptContext_match ds ] Bool }
                        (lam
                          ds
                          TxInfo
                          (lam
                            ds
                            ScriptPurpose
                            {
                              [
                                [
                                  {
                                    [ CampaignAction_match act ]
                                    (all dead (type) Bool)
                                  }
                                  (abs dead (type) [ [ validCollection c ] ds ])
                                ]
                                (abs
                                  dead (type) [ [ [ validRefund c ] con ] ds ]
                                )
                              ]
                              (all dead (type) dead)
                            }
                          )
                        )
                      ]
                    )
                  )
                )
              )
            )
            mkValidator
          )
        )
      )
    )
  )
)