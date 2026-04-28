functor MkUnweightedASP
  (structure Table : ORDTABLE)
  :> UNWEIGHTED_ASP where type vertex = Table.Key.t and Seq = Table.Seq =
struct
  structure Seq = Table.Seq
  structure Set = Table.Set

  exception NotYetImplemented

  type vertex = Table.Key.t
  type edge = vertex * vertex

  (* You must define the following two types *)
  type graph = Set.t Table.t
  type asp = vertex Seq.t Table.t

  fun makeGraph (E : edge Seq.t) : graph = Table.map Set.fromSeq (Table.collect E)

  fun makeASP (G : graph) (v : vertex) : asp =
    let
      (* Canonical BFS with Distance Tracking *)
      fun bfs (G : graph) (v : vertex) : (int Table.t * int) = let
        fun explore X F i =
          if Set.size F = 0 then (X, i-1)
          else let
            val F' = Table.tabulate (fn k => i) F
            val X' = Table.union (fn (x, _) => x) (X, F')
            (* Review Cost Bounds for below *)
            val F'' = Table.reduce Set.union (Set.empty ())
                     (Table.difference ((Table.restrict (G, F)), X))
          in explore X' F'' (i+1) end
        in explore (Table.empty ()) (Set.$ v) 0 end
      val (D, i) = bfs G v
      (* Parents Tracking *)
      val T = let
        val seqG = Table.toSeq G
        val P = let
          fun f (v, N) = let
            val N' = Set.toSeq N
          in Seq.map (fn n => (n, v)) N' end
        in Seq.map f seqG end
        fun p (u, v) =
          (case (Table.find D u, Table.find D v) of
                (SOME d1, SOME d2) => d2 < d1
              | _ => false)
      in Seq.filter p (Seq.flatten P) end
    in Table.collect T end

  fun report (A : asp) (v : vertex) : vertex Seq.t Seq.t = let
    fun report' (v : vertex) : vertex list list =
    (case Table.find A v of
          NONE => [[v]]
        | SOME N => let
            val Ps = Seq.map report' N
            val Ps' = List.concat (Seq.toList Ps)
            val Ps'' = List.map (fn P => v :: P) Ps'
          in Ps'' end)
    val pathList = report' v
  in Seq.map (Seq.fromList o List.rev) (Seq.fromList pathList) end
end
