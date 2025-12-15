use shipments;
GO

CREATE INDEX idx_shipments_port_lading ON shipments(port_lading_id);
CREATE INDEX idx_shipments_port_unlading ON shipments(port_unlading_id);
CREATE INDEX idx_shipments_arrival_date ON shipments(arrival_date_id);
CREATE INDEX idx_shipments_estimated_arrival_date ON shipments(estimated_arrival_id);
CREATE INDEX idx_shipments_weight ON shipments(weight_id);
CREATE INDEX idx_shipments_manifest_quant ON shipments(manifest_quantity_id);
CREATE INDEX idx_shipments_weight_unit ON shipments(weight_unit_id);
