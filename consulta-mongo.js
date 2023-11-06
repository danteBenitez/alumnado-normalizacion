/*
 Averiguar notas que corresponden a alumnos en años en los que no estuvieron I
const result = db.notas.aggregate([
    {
        $lookup: {
            from: "alumnos",
            foreignField: "_id",
            localField: "_id.dni",
            as: "alumno"
        }
    },
    {
        $unwind: "$alumno"
    },
    {
        $match: {
            $expr: {
                $or: [
                    {
                        $and: [
                            { $eq: ["$_id.anio_que_cursa", { $toString: "$alumno.grado2021" }] },
                            { $eq: ["$_id.anio_lectivo", "2021"] }
                        ],
                    },
                    {
                        $and: [
                            { $eq: ["$_id.anio_que_cursa", { $toString: "$alumno.grado2022" }] },
                            { $eq: ["$_id.anio_lectivo", "2022"] }
                        ],
                    }
                ]
            }
        }
    }
])
*/
[
  {
    $addFields: {
      materiaId: {
        $concat: [
          "$_id.dni",
          "$_id.anio_lectivo",
          "$_id.plan",
          "$_id.anio_que_cursa",
          "$_id.materia_nro",
        ],
      },
    },
  },
  {
    $lookup: {
      from: "notas",
      localField: "materiaId",
      foreignField: "_id",
      as: "materia"
    },
  },
  {
    $unwind: "$materia"
  },
  {
    $match: {
        materia: { $size: { $lt: 1 } }
    }
  }
];
